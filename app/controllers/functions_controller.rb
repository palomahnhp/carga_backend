class FunctionsController < ApplicationController

  respond_to :html, :js, :json

  def index
    if params[:search].present? || params[:searchByUser].present?
      if params[:search].present?
        @functions = Function.not_extra_functions.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
        @unpaginated_functions = Function.not_extra_functions.search(params[:search]).order('id DESC')
        if params[:searchByUser].present?
          @functions = @functions.searchByUser(params[:searchByUser]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
          @unpaginated_functions = @unpaginated_functions.searchByUser(params[:searchByUser]).order('id DESC')
        end
      else
        @functions = Function.not_extra_functions.searchByUser(params[:searchByUser]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
        @unpaginated_functions = Function.not_extra_functions.searchByUser(params[:searchByUser]).order('id DESC')
      end
    else
      @functions = Function.not_extra_functions.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_functions = Function.not_extra_functions
    end

    checkAjaxNew
    checkAjaxEdit

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Function.to_csv(@unpaginated_functions), filename: "Funciones.csv" }
      format.json { render json: @entitySearch.to_json }
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
      position_id:          params[:position]
    )
    @function.save

    redirect_to action: :index
  end

  def update
    @function = Function.find(params[:id])
    @function.update_attributes(
      name:                 params[:name],
      position_id:          params[:position]
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

  def checkAjaxNew
    if params[:edit]
      case params[:edit]
        when "direction"
          @entitySearch = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
        when "subdirection"
          @entitySearch = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
        when "unit"
          @entitySearch = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir])
        when "position"
          id = Unit.select(:id).find_by(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir], name: params[:unit])
          @entitySearch = Position.select(:id, :name, :position_number).where(unit_id: id)
      end
    end
  end

  def checkAjaxEdit
    if params[:op]
      @dir = Unit.select(:dir_name).where(area_name: params[:area]).group(:dir_name)
      @subdir = Unit.select(:subdir_name).where(area_name: params[:area], dir_name: params[:dir]).group(:subdir_name)
      @unit = Unit.select(:name).where(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir])
      id = Unit.select(:id).find_by(area_name: params[:area], dir_name: params[:dir], subdir_name: params[:subdir], name: params[:unit])
      @pos = Position.select(:id, :name, :position_number).where(unit_id: id)
      @entitySearch = {
        dir: @dir,
        subdir: @subdir,
        unit: @unit,
        pos: @pos
      }
    end
  end

end
