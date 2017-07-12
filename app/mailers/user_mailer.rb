class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.default_email_sender

  def reminder_email(mail_address, options = {})
    @message = options[:message]
    mail(from: options[:sender].presence || Rails.application.secrets.default_email_sender, to: mail_address, subject: options[:subject])
  end

  def group_email(mail_address, options = {})
    @message = options[:message]
    mail(from: options[:sender].presence || Rails.application.secrets.default_email_sender, to: mail_address, bcc: options[:bcc], subject: options[:subject])
  end
end
