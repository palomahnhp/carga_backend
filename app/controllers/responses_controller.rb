class ResponsesController < ApplicationController
  def index
    @responses = Response.all
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
    @function = Function.create(
      position_id:     current_user.position_id,
      name:            params[:name],
      function_number: params[:function_number],
      num_task:        params[:num_task],
      not_norm:        params[:not_norm]
    )
    if @response.save && @function.save
      puts 'survey sent'
    end
  end

  def submit_survey
  end
end
