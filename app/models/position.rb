class Position < ActiveRecord::Base
  has_many :users
  has_many :functions
  belongs_to :unit
  validates :name, :position_number, presence: true
  validates :position_number, presence: true, uniqueness: true

  def self.search(search)
    self.where("(name || position_number) ILIKE ?", "%#{search}%")
  end

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Nº Puesto", "Puesto"]
      records.each do |record|
        csv << [record.position_number, record.name]
      end
    end
  end
end
