class PositionsController < ApplicationController

  respond_to :html, :js, :json

  def index
    if params[:search].present?
      @positions = Position.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_positions = Position.search(params[:search]).order('id DESC')
    else
      @positions = Position.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_positions = Position.all
    end

    checkAjaxNew
    checkAjaxEdit

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Position.to_csv(@unpaginated_positions), filename: "Puestos.csv" }
      format.json { render json: @entitySearch.to_json }
    end
  end

  def show
    @position = Position.find(params[:id])
  end

  def edit
    @position = Position.find(params[:id])
  end

  def create
    @position = Position.create(
      position_number: params[:position_number],
      name:            params[:name],
      unit_id:         params[:unit_id]
    )
    @position.save

    redirect_to action: :index
  end

  def update
    @position = Position.find(params[:id])
    @position.update_attributes(
      position_number: params[:position_number],
      name:            params[:name],
      unit_id:         params[:unit_id]
    )
    redirect_to action: :index
  end

  def delete
    @position = Position.find(params[:id])
    users = User.where(position: @position)
    if users.any?
      alert = "No se puede borrar el puesto porque existen usuarios pertenecientes a él"
      redirect_to action: :edit, id: params[:id], alert: alert
      return
    else
      if @position.functions
        @position.functions.each do |function|
          function.destroy
        end
      end
    end
    
    @position.destroy
    redirect_to action: :index
  end

  private

  def position_params
    params.require(:position).permit(:position_number, :name, :unit_id, :description)
  end

  def checkAjaxNew
    if params[:edit]
      case params[:edit]
        when "direction"
          @entitySearch = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
        when "subdirection"
          @entitySearch = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
        when "unit"
          @entitySearch = Unit.select(:id, :name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir]).group(:id, :name)
      end
    end
  end

  def checkAjaxEdit
    if params[:op]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @unit = Unit.select(:id, :name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir]).group(:id, :name)
      @entitySearch = {
        dir: @dir,
        subdir: @subdir,
        unit: @unit
      }
    end
  end

end
