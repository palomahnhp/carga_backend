class SurveysController < ApplicationController
  def index
    @current_user
  end

  def show
    @current_user
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
      redirect_to action: :index
      puts 'survey sent'
    else
      if @response.errors
        @errors = []
        @response.errors.full_messages.each do |error|
          @errors << error
        end
        puts @response.errors.full_messages.to_s
        puts @errors
        puts "****************************************"
        redirect_to action: :show
      end
    end
  end
end
