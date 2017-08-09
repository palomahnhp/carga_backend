class ResponsesController < ApplicationController
  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order('id DESC')
    else
      @users = User.all.order('id DESC')
    end
    @responses = Response.all
  end

  def show
    @user = User.find(params[:id])
    @responses = Response.where(user_id: @user.id)
  end
end
