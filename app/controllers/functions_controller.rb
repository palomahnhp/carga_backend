class FunctionsController < ApplicationController
  def index
    @functions = Function.all
    if params[:search]
      @functions = Function.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @functions = Function.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end
  end

  def show
    @function = Function.find(params[:id])
  end

  def edit
    @function = Function.find(params[:id])
  end

  def create
    @function = Function.create(
      name:                 params[:name],
      position_id:          params[:position_id]
      )
    if @function.save
      puts 'function saved'
    end
    redirect_to action: :index
  end

  def update
    @function = Function.find(params[:id])
    @function.update_attributes(
      name:                 params[:name],
      position_id:          params[:position_id]
    )
    redirect_to action: :index
  end

  def delete
    @function = Function.find(params[:id])
    @function.destroy
    redirect_to action: :index
  end

  private

  def function_params
  params.require(:function).permit(:name, :position_id)
  end
end
