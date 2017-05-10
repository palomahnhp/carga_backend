class WelcomeController < ApplicationController
  def index
    @current_user
  end

  def survey
    @current_user
  end

  def admin
    @current_user
  end

  def send_mail
    begin
      UserMailer.reminder_email.deliver_now
      redirect_to admin_path, notice: I18n.t('success_message_sending')
    rescue Exception  => e
      Rails.logger.error('VolunteersController#send_mail') do
        "Error sending Email: \n#{e}"
      end
      redirect_to admin_path, alert: I18n.t('alert_message_sending')
    end
  end
end
