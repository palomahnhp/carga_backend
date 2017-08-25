class Function < ActiveRecord::Base
  has_many :responses
  belongs_to :position

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end

  def self.searchByUser(searchByUser)
    position_id = User.select(:position_id).where("(name || last_name || last_name_alt || user_num) ILIKE ?", "%#{searchByUser}%")
    self.where(position_id: position_id)
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Función", "Puesto"]
      records.each do |record|
        name = record.name.include?('’') ? record.name.gsub!('’', '\'') : record.name
        name = record.name.include?('…') ? record.name.gsub!('…', '...') : record.name
        csv << [name, record.position.name]
      end
    end
  end
end
