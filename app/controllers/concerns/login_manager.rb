class LoginManager

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
    if user
      ActiveRecord::Base.transaction do
        self.user.update_attributes(
          login:                 login_data[:login]
        )
        copy_errors_from!(user) unless user.save
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
end
