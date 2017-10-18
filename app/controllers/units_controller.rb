class UnitsController < ApplicationController
  
  respond_to :html, :js, :json

  def index
    if params[:search].present?
      @units = Unit.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_units = Unit.search(params[:search]).order('id DESC')
    else
      @units = Unit.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_units = Unit.all
    end

    if (params[:op])
      respond_to do |format|
        format.html
        format.js
        format.csv { send_data Unit.to_csv_track(@unpaginated_units), filename: "Seguimiento.csv" }
      end
    else
      checkAjaxNew
      checkAjaxEdit
      respond_to do |format|
        format.html
        format.js
        format.csv { send_data Unit.to_csv(@unpaginated_units), filename: "Unidades.csv" }
        format.json { render json: @entitySearch.to_json }
      end
    end
  end

  def tracking
    if params[:search].present? || (params[:responded].present? && params[:responded] == "true")
      if params[:search].present?
        @units = Unit.searchName(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
        if params[:responded].present? && params[:responded] == "true"
          @units = @units.responded.paginate(:page => params[:page], :per_page => params[:per_page]||10)
        end
      else
        @units = Unit.responded.paginate(:page => params[:page], :per_page => params[:per_page]||10)
      end
    else
      @units = Unit.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end
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
      #cod_area:   params[:cod_area],
      area_name:   params[:area_name],
      #cod_dir:    params[:cod_dir],
      dir_name:    params[:dir_name],
      #cod_subdir: params[:cod_subdir],
      subdir_name: params[:subdir_name]
    )
    
    unless @unit.save
      redirect_to action: :new, search: params[:search],
                                error: "El número de unidad ya está en uso",
                                unit_number: params[:unit_number],
                                name: params[:name],
                                campaign_id: params[:campaign_id],
                                alias: params[:alias],
                                area_name: params[:area_name],
                                dir_name: params[:dir_name],
                                subdir_name: params[:subdir_name]
      return
    end

    redirect_to action: :index
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(
      unit_number: params[:unit_number],
      name:        params[:name],
      campaign_id: params[:campaign_id],
      alias:       params[:alias],
      #cod_area:   params[:cod_area],
      area_name:   params[:area_name],
      #cod_dir:    params[:cod_dir],
      dir_name:    params[:dir_name],
      #cod_subdir: params[:cod_subdir],
      subdir_name: params[:subdir_name]
    )

    unless @unit.save
      redirect_to action: :edit, id: params[:id],
                                search: params[:search],
                                error: "El número de unidad ya está en uso",
                                unit_number: params[:unit_number],
                                name: params[:name],
                                campaign_id: params[:campaign_id],
                                alias: params[:alias],
                                area_name: params[:area_name],
                                dir_name: params[:dir_name],
                                subdir_name: params[:subdir_name]
      return
    end

    redirect_to action: :index
  end

  def delete
    @unit = Unit.find(params[:id])
    if @unit.positions
      @unit.positions.each do |position|
        users = User.where(position: position)
        if users.any?
          alert = "No se puede borrar la unidad porque existen usuarios pertenecientes a alguno de sus puestos"
          redirect_to action: :edit, id: params[:id], alert: alert
          return
        else
          if position.functions
            position.functions.each do |function|
              function.destroy
            end
          end
          position.destroy
        end
      end
    end

    @unit.destroy
    redirect_to action: :index
  end

  def user_list
    @unit = Unit.find(params[:id])
    @users = []
    @unit.positions.each do |position|
      position.users.each do |user|
        @users << user
      end
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
    message = params[:message].include?("\r\n") ? params[:message].gsub!("\r\n", "<br>") : params[:message]
    UserMailer.reminder_email(params[:recipient], message: message.html_safe, subject: params[:subject]).deliver_now
    redirect_to action: :tracking
  end

  def group_mail
    unit = Unit.find(params[:id])
    @recipient = []
    unit.positions.each do |position|
      position.users.each do |user|
        @recipient << user.email
      end
    end
    respond_to do |format|
      format.html
    end
  end

  def non_response_mail
    respond_to do |format|
      format.html
    end
  end

  def send_mails
    message = params[:message].include?("\r\n") ? params[:message].gsub!("\r\n", "<br>") : params[:message]
    UserMailer.group_email("madrid@madrid.es",bcc: params[:bcc], message: message.html_safe, subject: params[:subject]).deliver_now
    redirect_to action: :tracking
  end

  def send_massive_mails
    message = params[:message].include?("\r\n") ? params[:message].gsub!("\r\n", "<br>") : params[:message]
    users = User.where.not(email: nil).where.not(email: '')
    emails_list = []
    users.each do |user|
      if Response.where(user: user).empty?
        emails_list << user.email
      end
    end
    saveList(emails_list)

    email_groups = emails_list.each_slice(500).to_a
    email_groups.each do |email_group|
      bbc_string = ""
      email_group.each do |email|
        bbc_string = "#{bbc_string}, #{email}"
      end
      UserMailer.group_email("",bcc: bbc_string, message: message.html_safe, subject: params[:subject]).deliver_now
    end

    redirect_to action: :tracking
  end

  def download_massive_mails_log
    respond_to do |format|
      format.csv {
        send_file(
          "#{Rails.root}/public/ListadoCorreos_UltimoEnvio.csv",
          filename: "ListadoCorreos_UltimoEnvio.csv",
          type: "text/csv"
        )
      }
      format.html
    end
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
    if params[:op_edit]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @entitySearch = {
        dir: @dir,
        subdir: @subdir
      }
    end
  end

  def saveList(emails_list)
    CSV.open("#{Rails.root}/public/ListadoCorreos_UltimoEnvio.csv", "wb") do |csv|
      csv << ["Correos"]
      emails_list.each do |email|
        csv << [email]
      end
    end
  end

end
