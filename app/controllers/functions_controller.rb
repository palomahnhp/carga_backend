class FunctionsController < ApplicationController
  def index
    @functions = Function.all
    if params[:search]
      @functions = Function.search(params[:search]).order('id DESC')
    else
      @functions = Function.all.order('id DESC')
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
      function_number:      params[:function_number],
      name:                 params[:name],
      position_id:          params[:position_id],
      num_task:             params[:num_task],
      position_type_id:     params[:position_type_id]
      )
    if @function.save
      puts 'function saved'
    end
    redirect_to action: :index
  end

  def update
    @function = Function.find(params[:id])
    @function.update_attributes(
      function_number:      params[:function_number],
      name:                 params[:name],
      position_id:          params[:position_id],
      num_task:             params[:num_task],
      position_type_id:     params[:position_type_id]
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
  params.require(:function).permit(:function_number, :name, :position_id, :position_type_id, :num_task)
  end
end
