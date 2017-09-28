class User < ActiveRecord::Base
  has_one :user_dir
  has_many :responses
  belongs_to :position

  enum user_role: { respondent: 0, admin: 1, superadmin: 2 }

  validates :position_id, presence: true

  def self.search(search)
    self.where("(name || last_name || last_name_alt || user_num) ILIKE ?", "%#{search}%")
  end

  def self.searchByUnit(searchByUnit)
    unitIds = Unit.select(:id).where("name ILIKE ?", "%#{searchByUnit}%")
    posIds = Position.select(:id).where(unit_id: unitIds)
    self.where(position_id: posIds)
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Nº Usuario", "Usuario", "Email"]
      records.each do |record|
        full_name = "#{record.name.include?('ਲ') ? record.name.gsub!('ਲ', 'Ñ') : record.name} "
        full_name += "#{record.last_name.include?('ਲ') ? record.last_name.gsub!('ਲ', 'Ñ') : record.last_name} "
        full_name += "#{record.last_name_alt.include?('ਲ') ? record.last_name_alt.gsub!('ਲ', 'Ñ') : record.last_name_alt}"
        csv << [record.user_num, full_name, record.email]
      end
    end
  end
end
