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
    @total_per = 100
    @position.functions.each do |function|
      @pos_functions << function
      @current_user.responses.each do |response|
        if response.function_id == function.id
          @pos_functions.delete(function)
          @total_per = @total_per - response.time_per.to_i
        end
      end
    end
    if @pos_functions == []
      redirect_to action: :index
    end
  end

  def reset_responses
    @position = Position.find(params[:id])
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
    @response = Response.create(
      user_id:     current_user.id,
      function_id: params[:function_id],
      time_per:    params[:time_per]
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
