class UsersController < ApplicationController
  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order('id DESC')
    else
      @users = User.all.order('id DESC')
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:role] == "1"
      superadmin_role = true
      admin_role      = false
      respondent_role = false
    elsif params[:role] == "2"
      superadmin_role = false
      admin_role      = true
      respondent_role = false
    else
      superadmin_role = false
      admin_role      = false
      respondent_role = true
    end
    @user = User.find(params[:id])
    @user.update_attributes(
      name:            params[:name],
      last_name:       params[:last_name],
      last_name_alt:   params[:last_name_alt],
      document:        params[:document],
      email:           params[:email],
      login:           params[:ayre],
      phone_number:    params[:phone_number],
      superadmin_role: superadmin_role,
      admin_role:      admin_role,
      respondent_role: respondent_role
      )
    redirect_to action: :index
  end

  def create
    User.create(
      name:          params[:name],
      last_name:     params[:last_name],
      last_name_alt: params[:last_name_alt],
      document:      params[:document],
      email:         params[:email],
      login:         params[:ayre],
      phone_number:  params[:phone_number]
      )
    redirect_to action: :index
  end

  private

  def user_params
  params.require(:user).permit(:name, :last_name, :last_name_alt, :document, :email, :login, :phone_number, :superadmin_role, :admin_role, :respondent_role)
  end
end
