class UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def create
    @unit = Unit.create(unit_number: params[:unit_number], name: params[:name])
    if @unit.save
      puts 'unit saved'
    end
    redirect_to action: :index
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(unit_number: params[:unit_number], name: params[:name])
    redirect_to action: :index
  end

  def delete
    @unit = Unit.find(params[:id])
    @unit.destroy
    redirect_to action: :index
  end

  private

  def unit_params
  params.require(:unit).permit(:unit_number, :name)
  end
end
