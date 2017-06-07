class PositionsController < ApplicationController
  def index
    @positions = Position.all
  end

  def create
    @position = Position.create(position_number: params[:position_number], name: params[:name], unit_id: params[:unit_id])
    if @position.save
      puts 'position saved'
    end
    redirect_to action: :index
  end

  def update
    @position = Position.find(params[:id])
    @position.update_attributes(position_number: params[:position_number], name: params[:name], unit_id: params[:unit_id])
    redirect_to action: :index
  end

  def delete
    @position = Position.find(params[:id])
    if @position.functions
      @position.functions.each do |function|
        function.destroy
      end
    end
    @position.destroy
    redirect_to action: :index
  end

  private

  def position_params
  params.require(:position).permit(:position_number, :name, :unit_id)
  end
end
