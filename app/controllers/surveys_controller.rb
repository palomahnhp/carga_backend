class SurveysController < ApplicationController
  def index
    if @current_user.position
    else
      @render = false
    end
  end

  def show
    @position = Position.find(params[:id])
    @pos_functions = []
    @position.functions.each do |function|
      @pos_functions << function
      @current_user.responses.each do |response|
        if response.function_id == function.id
          @pos_functions.delete(function)
        end
      end
    end
    if @pos_functions == []
      redirect_to action: :index
    end
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
