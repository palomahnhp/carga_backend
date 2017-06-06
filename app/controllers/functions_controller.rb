class FunctionsController < ApplicationController
  def index
    @functions = Function.all
  end

  def create
    @function = Function.create(function_number: params[:function_number], name: params[:name], position_id: params[:position_id])
    if @function.save
      puts 'function saved'
    end
    redirect_to action: :index
  end

  def update
    @function = Function.find(params[:id])
    @function.update_attributes(function_number: params[:function_number], name: params[:name], position_id: params[:position_id])
    redirect_to action: :index
  end

  def delete
    @function = Function.find(params[:id])
    @function.destroy
    redirect_to action: :index
  end

  private

  def function_params
  params.require(:function).permit(:function_number, :name, :position_id)
  end
end
