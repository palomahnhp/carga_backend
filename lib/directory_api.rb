class DirectoryApi
  #deactivated for testing
  #integrated with uweb
  #see instructions below to make it work

  def initialize(data = {})
    @user_params = { login: data[:login] }.with_indifferent_access
    @errors      = []
  end

  def client
    @directory_client ||= Savon.client(wsdl: Rails.application.secrets.directorio_wsdl,encoding: 'ISO-8859-1', raise_errors: true)
  end

  def directory
    #you can integrate directory with uweb adding these lines into uweb authenticator + get_d_user_data + client(rename it to d_client and change also d_client in d_response instead of client)
    d_operation         = :datos_empleados
    d_response          = client.call(d_operation.to_sym, message: { aplicacion: Rails.application.secrets.directorio_application_key, i_pernr: nil, i_nif: nil, i_ayre: @user_params[:login]}).body
    d_parsed_response   = parser.parse(d_response[(d_operation.to_s + '_response').to_sym][(d_operation.to_s + '_return').to_sym])
    self.uweb_user_data = Hash.deep_strip! get_d_user_data(d_parsed_response)
    #you can add rescue for getting errors
  end

  private

  def get_d_user_data(d_parsed_response)
    #add all these attributes in the user table, they are just for checking
    return unless d_parsed_response == nil
    user_data = d_parsed_response.fetch('EMPLEADOS_ACTIVOS').fetch('EMPLEADO')
    {
      position_id:          user_data['ID_PUESTO'],
      position_name:        user_data['DENOMINACION_PUESTO'],
      functional_unit_id:   user_data['ID_UNIDAD_FUNCIONAL'],
      functional_unit_name: user_data['DEN_UNIDAD_FUNCIONAL'],
      org_code:             user_data['COD_ORGANICO'],
      category:             user_data['CATEGORIA'],
      category_name:        user_data['DEN_CATEGORIA'],
      level:                user_data['NIVEL'],
      personal_area:        user_data['AREA_PERSONAL'],
      personal_area_name:   user_data['DEN_AREA_PERSONAL'],
    }
  end

  def parser
    @parser ||= Nori.new
  end

  def application_key
    Rails.logger.info { "  INFO - UwebAuthenticator#application_key: Aplicación UWEB :  #{Rails.application.secrets.uweb_application_key.to_s}" }
    Rails.application.secrets.uweb_application_key.to_s
  end
end
