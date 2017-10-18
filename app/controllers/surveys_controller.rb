class SurveysController < ApplicationController

  respond_to :html, :js, :json

  def index
    @current_user = current_user
    if @current_user.position
    else
      @render = false
    end
    @positions = Position.where(id: User.select(:position_id).where(document: current_user.document))
    @user_positions = []
    @positions.each do |position|
      if position.unit.campaign.active?
        @user_positions << position
      end
    end
  end

  def show
    @pos_functions = fillPosFunctions
    unless @pos_functions.any?
      redirect_to action: :index
    end
  end

  def create
    @pos_functions = fillPosFunctions
    @unit = fillPosUnit
    @user = fillPosUser
    @errors = []
    
    # Guardar las respuestas
    @pos_functions.each do |func|
      time_per_id = "time_per_#{func.id}"
      @response = Response.create(
        user:        @user,
        function_id: func.id,
        time_per:    params[time_per_id]
      )
    end

    createExtraResponses
    @unit.update_attributes!(any_answer: true)

    redirect_to root_path
  end

  def download_calc
    respond_to do |format|
      format.csv {
        send_file(
          "#{Rails.root}/public/Calculadora dedicaciones_V.6.0.xlsm",
          filename: "Calculadora dedicaciones_V.6.0.xlsm",
          type: "application/vnd.ms-excel.sheet.macroEnabled.12"
        )
      }
    end
  end

  def download_manual
    respond_to do |format|
      format.csv {
        send_file(
          "#{Rails.root}/public/Manual Cuestionario Online_V.6.0.pdf",
          filename: "Manual Cuestionario Online_V.6.0.pdf",
          type: "application/pdf"
        )
      }
    end
  end

  private

  def setCurrentUser
    @current_user = current_user
  end

  def fillPosFunctions
    setCurrentUser
    @position = Position.friendly.find(params[:id])
    
    @pos_functions = @position.functions.not_extra_functions
  end

  def fillPosUnit
    setCurrentUser
    @position = Position.friendly.find(params[:id])

    @unit = @position.unit
  end
  
  def fillPosUser
    @logged_user = setCurrentUser
    @position = Position.friendly.find(params[:id])
    
    @user = User.find_by(document: @logged_user.document, position_id: @position.id)
  end

  def createExtraResponses
    if params["time_per_1001"]
      function = Function.create(
        position: @position,
        name: params["other_task_1001"],
        not_norm: 't'
      )
      unless function.save
        function_name = Function.select(:name).where("name ILIKE ? AND position_id = ?", "#{params["other_task_1001"]}%", @user.position).order(:name)     
        function_name = "#{function_name.last.name} "
        function = Function.create(
          position: @position,
          name: function_name,
          not_norm: 't'
        )
      end
      @response = Response.create(
        user:        @user,
        function:    function,
        time_per:    params["time_per_1001"]
      )
    end
    if params["time_per_1002"]
      function = Function.create(
        position: @position,
        name: params["other_task_1002"],
        not_norm: 't'
      )
      unless function.save
        function_name = Function.select(:name).where("name ILIKE ? AND position_id = ?", "#{params["other_task_1002"]}%", @user.position).order(:name)
        function_name = "#{function_name.last.name} "
        function = Function.create(
          position: @position,
          name: function_name,
          not_norm: 't'
        )
      end
      @response = Response.create(
        user:        @user,
        function:    function,
        time_per:    params["time_per_1002"]
      )
    end
    if params["time_per_1003"]
      function = Function.create(
        position: @position,
        name: params["other_task_1003"],
        not_norm: 't'
      )
      unless function.save
        function_name = Function.select(:name).where("name ILIKE ? AND position_id = ?", "#{params["other_task_1003"]}%", @user.position).order(:name)
        function_name = "#{function_name.last.name} "
        function = Function.create(
          position: @position,
          name: function_name,
          not_norm: 't'
        )
      end
      @response = Response.create(
        user:        @user,
        function:    function,
        time_per:    params["time_per_1003"]
      )
    end
  end

end
