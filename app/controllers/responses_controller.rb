class ResponsesController < ApplicationController
  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end
    @responses = Response.all
  end

  def show
    @user = User.find(params[:id])
    @responses = Response.where(user_id: @user.id)
  end
end
