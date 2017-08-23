class UnitsController < ApplicationController
  
  respond_to :html, :js, :json

  def index
    @units = Unit.all
    if params[:search]
      @units = Unit.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @units = Unit.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end

    if (params[:op])
      @unpaginated_units = Unit.all
      respond_to do |format|
        format.html
        format.js
        format.csv { send_data Unit.to_csv_track(@unpaginated_units), filename: "Seguimiento.csv" }
      end
    else
      checkAjaxNew
      checkAjaxEdit
      @unpaginated_units = Unit.all
      respond_to do |format|
        format.html
        format.js
        format.csv { send_data Unit.to_csv(@unpaginated_units), filename: "Unidades.csv" }
        format.json { render json: @entitySearch.to_json }
      end
    end
  end

  def tracking
    @units = Unit.all
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def new
  end

  def create
    @unit = Unit.create(
      unit_number: params[:unit_number],
      name:        params[:name],
      campaign_id: params[:campaign_id],
      alias:       params[:alias],
      cod_area:    params[:cod_area],
      area_name:   params[:area_name],
      cod_dir:     params[:cod_dir],
      dir_name:    params[:dir_name],
      cod_subdir:  params[:cod_subdir],
      subdir_name: params[:subdir_name]
      )
    @unit.save

    redirect_to action: :index
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(
      unit_number: params[:unit_number],
      name:        params[:name],
      campaign_id: params[:campaign_id],
      alias:       params[:alias],
      cod_area:    params[:cod_area],
      area_name:   params[:area_name],
      cod_dir:     params[:cod_dir],
      dir_name:    params[:dir_name],
      cod_subdir:  params[:cod_subdir],
      subdir_name: params[:subdir_name]
      )
    redirect_to action: :index
  end

  def delete
    @unit = Unit.find(params[:id])
    if @unit.positions
      @unit.positions.each do |position|
        if position.functions
          position.functions.each do |function|
            function.destroy
          end
        end
        position.destroy
      end
    end
    @unit.destroy
    redirect_to action: :index
  end

  def user_list
    @unit = Unit.find(params[:id])
    @users = []
    @unit.positions.each do |position|
        @users << position.user
    end
  end

  def show_mail
    @user = User.find(params[:id])
    @recipient = @user.email
    respond_to do |format|
      format.html
    end
  end

  def send_mail
    UserMailer.reminder_email(params[:recipient], message: params[:message], subject: params[:subject]).deliver_now
    redirect_to action: :tracking
  end

  def group_mail
    unit = Unit.find(params[:id])
    @recipient = []
    unit.positions.each do |position|
        @recipient << position.user.email
    end
    respond_to do |format|
      format.html
    end
  end

  def send_mails
    UserMailer.group_email("madrid@madrid.es",bcc: params[:bcc], message: params[:message], subject: params[:subject]).deliver_now
    redirect_to action: :tracking
  end

  private

  def unit_params
    params.require(:unit).permit(:unit_number, :name, :campaign_id, :alias, :cod_area, :area_name, :cod_dir, :dir_name, :cod_subdir, :subdir_name)
  end

  def checkAjaxNew
    if params[:edit]
      case params[:edit]
        when "direction"
          @entitySearch = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
        when "subdirection"
          @entitySearch = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      end
    end
  end

  def checkAjaxEdit
    if params[:op]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @entitySearch = {
        dir: @dir,
        subdir: @subdir
      }
    end
  end

end
