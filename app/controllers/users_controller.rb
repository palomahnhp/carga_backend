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
    @positions = Position.all
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
      position_id:     params[:position].to_i
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
    params.require(:user).permit(:name, :last_name, :last_name_alt, :document, :email, :login, :phone_number, :user_role, :position_id)
  end
end
