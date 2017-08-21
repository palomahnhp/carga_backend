class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :function

  validates :time_per, presence: {message: "Falta porcentaje de tiempo de la tarea"}
  # validates :num_task, presence: {message: "Falta número de tareas"}
  # validates :min_time, presence: {message: "Falta tiempo mínimo de la tarea"}
  # validates :avg_time, presence: {message: "Falta tiempo medio de la tarea"}
  # validates :max_time, presence: {message: "Falta tiempo medio de la tarea"}

  def self.to_csv(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Puesto", "Función", "Respuesta"]
      records.each do |record|
        csv << [record.function.position.name, record.function.name, "#{record.time_per} %"]
      end
    end
  end
end
