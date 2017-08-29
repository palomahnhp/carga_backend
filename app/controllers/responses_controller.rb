class ResponsesController < ApplicationController

  respond_to :html, :js, :json  

  def index
    @users = User.where(id: Response.select(:user_id))
    if params[:search].present? || params[:searchByUnit].present?
      if params[:search].present?
        @users = @users.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
        if params[:searchByUnit].present?
          @users = @users.searchByUnit(params[:searchByUnit]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
        end
      else
        @users = @users.searchByUnit(params[:searchByUnit]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      end
    else
      @users = @users.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
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
