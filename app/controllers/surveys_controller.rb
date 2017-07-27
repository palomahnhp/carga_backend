class SurveysController < ApplicationController
  def index
    @positions = @current_user.positions.all

    if @current_user.positions
      fun_col = []
      res_col = []
      @current_user.positions.each do |position|
        position.functions.each do |function|
          @current_user.responses.each do |response|
            if response.function_id == function.id
              @p_id = position.id
            end
          end
        end
      end
      @current_user.responses.each do |response|
        res_col << response.function_id
      end
      @current_user.positions.each do |position|
        position.functions.each do |function|
          fun_col << function.id
        end
      end
      if (fun_col != []) && (fun_col == res_col)
        @render = false
      else
        @render = true
      end
    else
      @render = false
    end
  end

  def show
    @position = Position.find(params[:id])
  end

  def create
    @response = Response.create(
      user_id:     current_user.id,
      function_id: params[:function_id],
      time_per:    params[:time_per],
      num_task:    params[:num_task],
      min_time:    params[:min_time],
      avg_time:    params[:avg_time],
      max_time:    params[:max_time]
      )
    if @response.save
      redirect_to :back
      puts 'survey sent'
    else
      if @response.errors
        @errors = []
        @response.errors.full_messages.each do |error|
          @errors << error
        end
        puts @errors
        redirect_to :back
      end
    end
  end
end
