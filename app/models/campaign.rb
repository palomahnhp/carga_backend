class Campaign < ActiveRecord::Base
  has_many :units
  enum status: { pending: 0, active: 1, completed: 2 }

  validates :end_date, presence: true
  validate :start_date_less_than_end_date

  scope :active, -> { where(status: 1) }

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Id", "Nombre", "Estado"]
      records.each do |record|
        case record.status
          when "active"
            csv << [record.id, record.name, "En curso"]
          when "completed"
            csv << [record.id, record.name, "Finalizada"]
          else
            csv << [record.id, record.name, "En borrador"]
        end
      end
    end
  end

  def active?
    status == Campaign.statuses.key(1)
  end

  private

  def start_date_less_than_end_date
    unless start_date < end_date
      errors.add(:end_date, "La fecha de finalización debe ser superior a la de inicio y a la actual")
    end
  end

end
