class UwebAuthenticator

  attr_accessor :errors, :uweb_user_data

  def initialize(data = {})
    @user_params = { login: data[:login] }.with_indifferent_access
    @errors      = []
  end

  def valid?
    unless @user_params[:login].present?
      errors << I18n.t('errors.missing_required_fields', default: 'Missing required fields' )
    end
    errors.blank?
  end

  def authenticate
    valid? && user_exists?
  end

  def user_exists?
    response = client.call(:get_user_data_by_login, message: { ub: { login: @user_params[:login] } }).body
    parsed_response = parser.parse(response[:get_user_data_by_login_response][:get_user_data_by_login_return])
    self.uweb_user_data = Hash.deep_strip! get_uweb_user_data(parsed_response)
    puts "****************************************"
    puts uweb_user_data
    puts "****************************************"

    uweb_user_data[:login].present?
    rescue  Exception  => e
      Rails.logger.error('UwebAuthenticator#user_exists?') do
        "Error llamada UWEB: get_user_data_by_login - #{@user_params}: \n#{e}"
    end
    errors << generate_error_message(e.message)
    false
  end

  def user_exists_by_dni?(document)
    response = client.call(:get_user_data_by_dni, message: { ub: { dni: document } }).body
    parsed_response = parser.parse(response[:get_user_data_by_dni_response][:get_user_data_by_dni_return])
    self.uweb_user_data = Hash.deep_strip! get_uweb_user_data(parsed_response)

    uweb_user_data[:document].present?
    rescue  Exception  => e
      Rails.logger.error('UwebAuthenticator#user_exists?') do
        "Error llamada UWEB: get_user_data_by_dni - #{document}: \n#{e}"
    end
    errors << generate_error_message(e.message)
    false
  end

  def user_auth_for_app?(uweb_id)
    response = client.call(:get_applications_user_list, message: { ub: { userKey: uweb_id } }).body
    parsed_response = parser.parse(response[:get_applications_user_list_response][:get_applications_user_list_return])  
    auth_apps = Hash.deep_strip! get_app_list(parsed_response)

    authorized = false
    auth_apps[:list].each do |app_key|
      if app_key['CLAVE_APLICACION'] == Rails.application.secrets.uweb_application_key.to_s
        authorized = true
        break
      end
    end
    
    authorized
    rescue  Exception  => e
      Rails.logger.error('UwebAuthenticator#user_exists?') do
        "Error llamada UWEB: get_applications_user_list - #{uweb_id}: \n#{e}"
    end
    errors << generate_error_message(e.message)
    false
  end

  private

    def generate_error_message(message)
      not_found_error_pattern = 'Usuario .* no encontrado'
      if /#{not_found_error_pattern}/ === message
        message.sub(/(?:(?!\b#{not_found_error_pattern}\b).)*/, '')
      else
        I18n.t('errors.service_temporally_unavailable',
               default: 'Service temporally unavailable. Please, try later.')
      end
    end

    def get_uweb_user_data(parsed_response)
      user_data = parsed_response.fetch('USUARIO')
      {
        login:             user_data['LOGIN'],
        uweb_id:           user_data['CLAVE_IND'],
        name:              user_data['NOMBRE_USUARIO'],
        last_name:         user_data['APELLIDO1_USUARIO'],
        last_name_alt:     user_data['APELLIDO2_USUARIO'],
        document:          user_data['DNI'],
        phone_number:      user_data['TELEFONO'],
        email:             user_data['MAIL']
      }
    end

    def get_app_list(parsed_response)
      app_list = parsed_response.fetch('APLICACIONES')
      {
        total:            app_list['TOTAL'],
        list:             app_list['APLICACION']
      }
    end

    def client
      @client ||= Savon.client(wsdl: Rails.application.secrets.uweb_wsdl, raise_errors: true)
    end

    def parser
      @parser ||= Nori.new
    end
end
