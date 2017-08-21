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

  def self.to_csv_track(records)
    CSV.generate(col_sep:';', encoding:'ISO-8859-1') do |csv|
      csv << ["Unidad", "Nº Usuarios", "Porcentaje de encuestas respondidas"]
      records.each do |record|
        users_responses_relation = record.responses_users
        csv << [record.name, users_responses_relation[:users], "#{users_responses_relation[:response_level]} %"]
      end
    end
  end

  def responses_users
    unit_users = []
    unit_responses = 0
    response_level = 0
    self.positions.each do |position|
      if position.user
        unit_users << position.user
        if position.user.responses != []
          unit_responses = 1 + unit_responses
        end
      end
    end

    if unit_users != []
      response_level = unit_responses*100/unit_users.count
    else
      response_level = 0
    end

    users_responses_relation = {users: unit_users.count, response_level: response_level}
  end

end
