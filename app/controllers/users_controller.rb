class UsersController < ApplicationController

  respond_to :html, :js, :json

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end

    @unpaginated_users = User.all
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
      name:            params[:name],
      last_name:       params[:last_name],
      last_name_alt:   params[:last_name_alt],
      document:        params[:document],
      email:           params[:email],
      login:           params[:ayre],
      phone_number:    params[:phone_number],
      user_role:       params[:role].to_i,
      position_id:     params[:position]
    )
    redirect_to action: :index
  end

  def create
    @user = User.create(
      name:          params[:name],
      last_name:     params[:last_name],
      last_name_alt: params[:last_name_alt],
      document:      params[:document],
      email:         params[:email],
      login:         params[:ayre],
      phone_number:  params[:phone_number],
      position_id:   params[:position]
    )
    @user.save

    redirect_to action: :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :last_name_alt, :document, :email, :login, :phone_number, :user_role, :position_id)
  end

  def checkAjaxNew
    if params[:edit]
      case params[:edit]
        when "direction"
          @entitySearch = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
        when "subdirection"
          @entitySearch = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
        when "unit"
          @entitySearch = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir]).group(:name)
        when "position"
          id = Unit.select(:id).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir], name: params[:unit])
          @entitySearch = Position.select(:id, :name).where(unit_id: id)
      end
    end
  end

  def checkAjaxEdit
    if params[:op]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @unit = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir]).group(:name)
      @pos = Position.select(:id, :name).where(id: params[:pos])
      @entitySearch = {
        dir: @dir,
        subdir: @subdir,
        unit: @unit,
        pos: @pos
      }
    end
  end

end
