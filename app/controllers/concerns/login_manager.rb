class LoginManager

  @@uweb_non_access = false
  cattr_reader :uweb_non_access
  
  attr_accessor :errors, :user, :login_data

  def initialize(options = {})
    self.login_data = options[:login_data]
    self.errors     = []
  end

  def valid?
    unless required_data_present?
      errors << I18n.t('errors.missing_required_fields')
    end
    errors.blank?
  end

  def find_or_create_user
    return unless valid?

    self.user = User.find_by(document: login_data[:document])
    data = employees_data(pern: nil, nif: login_data[:document])
    if user && data['EMPLEADOS_ACTIVOS'] != nil
      ActiveRecord::Base.transaction do
        self.user.update_attributes(
          login:                 login_data[:login]
        )
        copy_errors_from!(user) unless user.save
      end

      unless UserDir.find_by(nif: login_data[:document]) != nil
      dir_data = data['EMPLEADOS_ACTIVOS']['EMPLEADO']
        ActiveRecord::Base.transaction do
          UserDir.create(
            user_id:             user.id,
            pernr:               dir_data['PERNR'],
            nif:                 dir_data['NIF'],
            ayre:                dir_data['AYRE'],
            last_name:           dir_data['APELLIDO1'],
            last_name_alt:       dir_data['APELLIDO2'],
            name:                dir_data['NOMBRE'],
            position_id:         dir_data['ID_PUESTO'],
            position_des:        dir_data['DENOMINACION_PUESTO'],
            functional_unit_id:  dir_data['ID_UNIDAD_FUNCIONAL'],
            functional_unit_des: dir_data['DEN_UNIDAD_FUNCIONAL'],
            organic_code:        dir_data['COD_ORGANICO'],
            category:            dir_data['CATEGORIA'],
            category_den:        dir_data['DEN_CATEGORIA'],
            level:               dir_data['NIVEL'],
            personal_area:       dir_data['AREA_PERSONAL'],
            personal_area_den:   dir_data['DEN_AREA_PERSONAL'],
            email:               dir_data['EMAIL']
          )
        end
      end
      uweb_non_access = false
    else
      if data['EMPLEADOS_ACTIVOS'] == nil
        uweb_non_access = true
      end
    end
    user
  end

  def login_data=(hash)
    @login_data = hash.present? ? hash.symbolize_keys : hash
  end

  private

  def copy_errors_from(record)
    self.errors += record.errors.full_messages
    nil
  end

  def copy_errors_from!(record)
    copy_errors_from(record)
    raise ActiveRecord::Rollback
  end

  def required_data_present?
    %i(login uweb_id email document).all? { |key| login_data.key? key }
  end

  def request(operation, message_params)
    response = d_client.call(operation.to_sym, message: message_params).body
    d_parsed_response = d_parser.parse(response[(operation.to_s + '_response').to_sym][(operation.to_s + '_return').to_sym])
    return d_parsed_response
  rescue Savon::Error => e
    puts "#{operation} - #{message_params} - Error Savon: #{e}"
    false
  end

  def employees_data(params)
    params[:i_tipoConsulta] = {only_unit: 1, all_down: 2}[params[:i_tipoConsulta]] if params[:i_tipoConsulta].present?
    message_params = {aplicacion: Rails.application.secrets.directorio_application_key}
    message_params.merge!(params)
    request(:datos_empleados, message_params)
  end

  def d_client
    @d_client ||= Savon.client(wsdl: Rails.application.secrets.directorio_wsdl, raise_errors: true)
  end

  def d_parser
    @parser ||= Nori.new
  end
  ######
end
