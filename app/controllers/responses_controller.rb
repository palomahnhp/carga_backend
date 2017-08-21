class ResponsesController < ApplicationController

  respond_to :html, :js, :json  

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @users = User.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end
    @responses = Response.all

    if (params[:id])
      @user = User.find(params[:id])
      @search_responses = Response.where(user_id: @user.id)
      respond_with(@responses) do |format|
        format.csv { send_data Response.to_csv(@search_responses), filename: "Respuestas_usuario_#{@user.user_num}.csv" }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @responses = Response.where(user_id: @user.id)
  end
end
