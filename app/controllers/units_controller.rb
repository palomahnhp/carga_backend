class UnitsController < ApplicationController
  def index
    @units = Unit.all
    if params[:search]
      @units = Unit.search(params[:search]).order('id DESC')
    else
      @units = Unit.all.order('id DESC')
    end
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def new
  end

  def create
    @unit = Unit.create(
      unit_number: params[:unit_number],
      name:        params[:name],
      campaign_id: params[:campaign_id],
      alias:       params[:alias],
      cod_area:    params[:cod_area],
      area_name:   params[:area_name],
      cod_dir:     params[:cod_dir],
      dir_name:    params[:dir_name],
      cod_subdir:  params[:cod_subdir],
      subdir_name: params[:subdir_name]
      )
    if @unit.save
      puts 'unit saved'
    end
    redirect_to action: :index
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(
      unit_number: params[:unit_number],
      name:        params[:name],
      campaign_id: params[:campaign_id],
      alias:       params[:alias],
      cod_area:    params[:cod_area],
      area_name:   params[:area_name],
      cod_dir:     params[:cod_dir],
      dir_name:    params[:dir_name],
      cod_subdir:  params[:cod_subdir],
      subdir_name: params[:subdir_name]
      )
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
  params.require(:unit).permit(:unit_number, :name, :campaign_id, :alias, :cod_area, :area_name, :cod_dir, :dir_name, :cod_subdir, :subdir_name)
  end
end
