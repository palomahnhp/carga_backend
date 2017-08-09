require 'application_responder'
require 'uweb_authenticator'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate!, unless: 'user_authenticated?'
  before_action :set_page_params, only: [:index]

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: I18n.t('messages.access_denied') }
      format.json { render json: {error: I18n.t('messages.access_denied')}, status: :forbidden }
    end
  end

  def uweb_authenticated?
    return true unless new_login?

    session[:current_user_id] = nil
    uweb_auth = UwebAuthenticator.new(params)
    if uweb_auth.authenticate
      session[:uweb_user_data]  = uweb_auth.uweb_user_data
    else
      flash.now[:error] = "#{I18n.t('errors.cannot_log_in')}: #{uweb_auth.errors.to_sentence}"
      
    end
    session[:uweb_user_data].present?
  end

  def new_login?
    session[:uweb_user_data].blank? || params[:login].present? && session[:uweb_user_data][:login] != params[:login]
  end

  private

  def update_record_history
    return unless recordable?
    record = instance_variable_get("@#{model.model_name.singular}")
    record.update_history(current_user.try(:id))
  end

  def recordable?
    model && model.included_modules.map(&:to_s).include?('Recordable')
  end

  def model
    @model ||= controller_name.classify.safe_constantize
  end

  def authenticate!
    unless uweb_authenticated? && current_user
      render file: 'public/401.html', status: :unauthorized
    end
  end

  def user_authenticated?
    #session[:uweb_user_data]
    #current_user.present?
    return true
  end

  def set_page_params
    params[:per_page_list] ||= [10,20,30,40,50]
    params[:per_page] ||= 20
  end

  def current_user
    @current_user ||= if true
                        find_or_create_user
                      end
  end

  def find_or_create_user
    user =  if session[:current_user_id].present?
              User.find_by(id: session[:current_user_id])
            else
              login_manager = LoginManager.new(login_data: { document: '51640586C' })
              if login_manager.find_or_create_user
                login_manager.user
              else
                flash[:error] = login_manager.errors.to_sentence
                nil
              end
            end
    session[:current_user_id] = user.try :id
    user
  end

  def fields_for_options(collection)
    collection.build if collection.empty?
  end
end
