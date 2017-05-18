class WelcomeController < ApplicationController
  def index
    @current_user
  end

  def survey
    @current_user
  end

  def settings
    @current_user
  end

  def tracking
    @current_user
  end

  def admin_panel
    @current_user
  end

  def show_mail
    respond_to do |format|
      format.html
    end
  end

  def send_mail
    begin
      UserMailer.reminder_email(params[:recipient], message: params[:message], subject: params[:subject]).deliver_now
      redirect_to tracking_path, notice: I18n.t('success_message_sending')
    rescue Exception  => e
      Rails.logger.error('VolunteersController#send_mail') do
        "Error sending Email: \n#{e}"
      end
      redirect_to admin_path, alert: I18n.t('alert_message_sending')
    end
  end
end
