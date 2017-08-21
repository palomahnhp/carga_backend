class Campaign < ActiveRecord::Base
  has_many :units
  enum status: { pending: 0, active: 1, completed: 2 }

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
end
