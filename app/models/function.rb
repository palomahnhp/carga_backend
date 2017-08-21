class Function < ActiveRecord::Base
  has_many :responses
  belongs_to :position

  def self.search(search)
    self.where("name ILIKE ?", "%#{search}%")
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Función", "Puesto"]
      records.each do |record|
        csv << [record.name.gsub!('\u2019', '\''), record.position.name]
      end
    end
  end
end
