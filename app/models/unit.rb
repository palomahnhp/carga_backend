class Unit < ActiveRecord::Base
  has_many :positions
  belongs_to :campaign

  def self.search(search)
    self.where("(name || dir_name || subdir_name || unit_number) ILIKE ?", "%#{search}%")
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Nº Unidad", "Unidad", "Dirección", "Subdirección"]
      records.each do |record|
        csv << [record.unit_number, record.name, record.dir_name, record.subdir_name]
      end
    end
  end
end
