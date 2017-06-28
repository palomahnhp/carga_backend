class WelcomeController < ApplicationController
  #prototype until structure and association info is revealed.
  #when we get the info, change welcome controller methods to their own controllers

  def index
    @current_user
  end

  def settings
    @current_user
  end

  def settings_campaigns
    @current_user
  end

  def tracking
    @current_user
  end

  def show_mail
    unit = Unit.find_by(id: 1)
    @group_recipient = []
    unit.positions.each do |position|
      position.users.each do |user|
        @group_recipient << user.email
      end
    end
    user = User.find_by(id: 1)
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
