class SurveysController < ApplicationController

  respond_to :html, :js, :json

  def index
    @current_user = current_user
    if @current_user.position
    else
      @render = false
    end
    user_data = User.where(document: current_user.document)
    @user_positions = []
    user_data.each do |record|
      position = Position.find(record.position_id)
      @user_positions << position
    end
  end

  def show
    @pos_functions = fillPosFunctions
    unless @pos_functions.any?
      redirect_to action: :index
    end
  end

  def reset_responses
    setCurrentUser
    @position = Position.friendly.find(params[:id])
    @position.functions.each do |function|
      @current_user.responses.each do |response|
        if response.function_id == function.id
          response.destroy
        end
      end
    end
    redirect_to action: :index
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
        user_id:     @user.id,
        function_id: func.id,
        time_per:    params[time_per_id]
      )
      unless @response.save
        if @response.errors
          @response.errors.full_messages.each do |error|
            @errors << error
          end
          puts @errors
        end
      end
    end

    createExtraResponses
    @unit.update_attributes!(any_answer: true)

    redirect_to root_path
  end

  def download_calc
    respond_to do |format|
      format.csv {
        send_file(
          "#{Rails.root}/public/Calculos dedicaciones_Macro_V.5.0.xlsm",
          filename: "Calculos dedicaciones_Macro_V.5.0.xlsm",
          type: "application/vnd.ms-excel.sheet.macroEnabled.12"
        )
      }
    end
  end

  def download_manual
    respond_to do |format|
      format.csv {
        send_file(
          "#{Rails.root}/public/Manual Cuestionario Online_V.5.0.pdf",
          filename: "Manual Cuestionario Online_V.5.0.pdf",
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
        position: current_user.position,
        name: params["other_task_1001"],
        not_norm: 't'
      )
      @response = Response.create(
        user_id:     current_user.id,
        function:    function,
        time_per:    params["time_per_1001"]
      )
    end
    if params["time_per_1002"]
      function = Function.create(
        position: current_user.position,
        name: params["other_task_1002"],
        not_norm: 't'
      )
      @response = Response.create(
        user_id:     current_user.id,
        function:    function,
        time_per:    params["time_per_1002"]
      )
    end
    if params["time_per_1003"]
      function = Function.create(
        position: current_user.position,
        name: params["other_task_1003"],
        not_norm: 't'
      )
      @response = Response.create(
        user_id:     current_user.id,
        function:    function,
        time_per:    params["time_per_1003"]
      )
    end
  end

end
