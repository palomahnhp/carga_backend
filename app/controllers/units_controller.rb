class UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def create
    @unit = Unit.create(unit_number: params[:unit_number], name: params[:name], campaign_id: params[:campaign_id])
    if @unit.save
      puts 'unit saved'
    end
    redirect_to action: :index
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(unit_number: params[:unit_number], name: params[:name], campaign_id: params[:campaign_id])
    redirect_to action: :index
  end

  def delete
    @unit = Unit.find(params[:id])
    if @unit.positions
      @unit.positions.each do |position|
        if position.functions
          position.functions.each do |function|
            function.destroy
          end
        end
        position.destroy
      end
    end
    @unit.destroy
    redirect_to action: :index
  end

  private

  def unit_params
  params.require(:unit).permit(:unit_number, :name, :campaign_id)
  end
end
