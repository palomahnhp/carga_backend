puts "\n\n--- ACTUALIZANDO ESTADO DE LAS CAMPAÑAS ---"

updated = 0
Campaign.all.each do |campaign|
  if (Time.now.to_date > campaign.end_date.to_date) && campaign.status != Campaign.statuses.key(2)
    campaign.update_attributes(status: Campaign.statuses[:completed])
    campaign.save(validate: false)
    puts "----- Campaña \"#{campaign.name}\" finalizada, fecha pasada de finalización: #{campaign.end_date.to_date} -----"
    updated += 1
  end
end

puts "--- CAMPAÑAS ACTUALIZADAS: #{updated}   ---"
puts "--- ACTUALIZACIÓN COMPLETADA            ---"