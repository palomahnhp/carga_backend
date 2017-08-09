class WelcomeController < ApplicationController
  #prototype until structure and association info is revealed.
  #when we get the info, change welcome controller methods to their own controllers

  def index
    @title = current_user.name.downcase.capitalize
    @d = DateTime.now
    if @d.hour > 12
      @greeting = "Buenas tardes"
    elsif @d.hour > 21
      @greeting = "Buenas noches"
    else
      @greeting = "Buenos días"
    end
  end

  def settings
    @current_user
  end

  def group_mail
    @recipient = user.email
    respond_to do |format|
      format.html
    end
  end

  def admin
  end
end
