class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(
      name:          params[:name],
      last_name:     params[:last_name],
      last_name_alt: params[:last_name_alt],
      document:      params[:document],
      email:         params[:email],
      phone_number:  params[:phone_number]
      )
    redirect_to action: :index
  end

  private

  def user_params
  params.require(:user).permit(:name, :last_name, :last_name_alt, :document, :email, :phone_number)
  end
end
