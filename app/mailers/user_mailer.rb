class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.default_email_sender

  def reminder_email
    mail(to: 'dnacenta2@gmail.com', subject: 'Hay que terminar lo que se empieza!')
  end
end
