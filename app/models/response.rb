class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :function

  validates :time_per, presence: { message: "Falta porcentaje de tiempo de la tarea" }
  validates :function_id, user_id, presence: true

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Puesto", "Función", "Respuesta"]
      records.each do |record|
        csv << [record.function.position.name, record.function.name, "#{record.time_per} %"]
      end
    end
  end
end
