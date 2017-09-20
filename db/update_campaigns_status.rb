puts "--- ACTUALIZANDO ESTADO DE LAS CAMPAÑAS ---"

Campaign.all.each do |campaign|
  if Time.now.to_date > campaign.end_date.to_date
    campaign.update_attributes!(status: Campaign.statuses[:completed])
  end
end

puts "--- ACTUALIZACIÓN COMPLETADA            ---"