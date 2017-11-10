class UsersController < ApplicationController

  respond_to :html, :js, :json

  def index
    if params[:search].present?
      @users = User.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_users = User.search(params[:search])
    else
      @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_users = User.all
    end

    checkAjaxNew
    checkAjaxEdit

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data User.to_csv(@unpaginated_users), filename: "Usuarios.csv" }
      format.json { render json: @entitySearch.to_json }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(
      user_num:        params[:user_num],
      name:            params[:name],
      last_name:       params[:last_name],
      last_name_alt:   params[:last_name_alt],
      document:        params[:document],
      email:           params[:email],
      login:           params[:ayre],
      phone_number:    params[:phone_number],
      user_role:       params[:role].to_i,
      position_id:     params[:position],
      start_date:      params[:start_date],
      end_date:        params[:end_date],
      annual_hours:    params[:annual_hours]
    )
    unless @user.save
      message = @user.errors[:position_id].present? ? @user.errors[:position_id].to_sentence : nil
      if message.nil?
        message = @user.errors[:document].to_sentence
      end
      redirect_to action: :edit, id: params[:id],
                                search: params[:search],
                                error: message,
                                user_num:        params[:user_num],
                                name:            params[:name],
                                last_name:       params[:last_name],
                                last_name_alt:   params[:last_name_alt],
                                document:        params[:document],
                                email:           params[:email],
                                ayre:            params[:ayre],
                                phone_number:    params[:phone_number],
                                user_role:       params[:role].to_i,
                                position_id:     params[:position],
                                start_date:      params[:start_date],
                                end_date:        params[:end_date],
                                annual_hours:    params[:annual_hours]
      return
    end
    redirect_to action: :index, search: params[:search]
  end

  def create
    @user = User.create(
      user_num:      params[:user_num],
      name:          params[:name],
      last_name:     params[:last_name],
      last_name_alt: params[:last_name_alt],
      document:      params[:document],
      email:         params[:email],
      login:         params[:ayre],
      phone_number:  params[:phone_number],
      position_id:   params[:position],
      start_date:    params[:start_date],
      end_date:      params[:end_date],
      annual_hours:  params[:annual_hours]
    )
    unless @user.save
      message = @user.errors[:position_id].present? ? @user.errors[:position_id].to_sentence : nil
      if message.nil?
        message = @user.errors[:document].to_sentence
      end
      redirect_to action: :new, search: params[:search],
                                error: message,
                                user_num:      params[:user_num],
                                name:          params[:name],
                                last_name:     params[:last_name],
                                last_name_alt: params[:last_name_alt],
                                document:      params[:document],
                                email:         params[:email],
                                ayre:          params[:ayre],
                                phone_number:  params[:phone_number],
                                position_id:   params[:position],
                                start_date:    params[:start_date],
                                end_date:      params[:end_date],
                                annual_hours:  params[:annual_hours]
      return
    end

    redirect_to action: :index, search: params[:search]
  end

  private

  def user_params
    params.require(:user).permit(:user_num, :name, :last_name, :last_name_alt, :document, :email, :login, :phone_number, :user_role, :position_id, :start_date, :end_date, :annual_hours)
  end

  def checkAjaxNew
    if params[:edit]
      case params[:edit]
        when "direction"
          @entitySearch = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
        when "subdirection"
          @entitySearch = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
        when "unit"
          @entitySearch = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir])
        when "position"
          id = Unit.select(:id).find_by(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir], name: params[:unit])
          @entitySearch = Position.select(:id, :name, :position_number).where(unit_id: id)
      end
    end
  end

  def checkAjaxEdit
    if params[:op]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @unit = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir])
      id = Unit.select(:id).find_by(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir], name: params[:unit])
      @pos = Position.select(:id, :name, :position_number).where(unit_id: id)
      @entitySearch = {
        dir: @dir,
        subdir: @subdir,
        unit: @unit,
        pos: @pos
      }
    end
  end

end
