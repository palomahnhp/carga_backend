class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(document: params[:document], email: params[:email], phone_number: params[:phone_number])
    redirect_to action: :index
  end

  private

  def user_params
  params.require(:user).permit(:document, :email, :phone_number)
  end
end
