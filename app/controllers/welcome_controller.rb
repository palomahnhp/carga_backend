class WelcomeController < ApplicationController
  #prototype until structure and association info is revealed.
  #when we get the info, change welcome controller methods to their own controllers

  def index
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

  def settings_campaigns
    @current_user
  end

  def tracking
    @units = Unit.all
  end

  def tracking_panel
    @current_user
  end

  def show_mail
    @user = User.find(params[:id])
    @recipient = user.email
    respond_to do |format|
      format.html
    end
  end

  def group_mail
    @recipient = user.email
    respond_to do |format|
      format.html
    end
  end

  def admin
  end

  def send_mail
    begin
      UserMailer.reminder_email(params[:recipient], message: params[:message], subject: params[:subject]).deliver_now
      redirect_to tracking_path, notice: I18n.t('success_message_sending')
    rescue Exception  => e
      Rails.logger.error('VolunteersController#send_mail') do
        "Error sending Email: \n#{e}"
      end
      redirect_to tracking_path, alert: I18n.t('alert_message_sending')
    end
  end
end
