puts "====== ACTUALIZANDO ESTADO DE LAS CAMPAÑAS ======"

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
##
updated = 0
Campaign.all.each do |campaign|
  if (Time.now.to_date >= campaign.start_date.to_date) && campaign.status == Campaign.statuses.key(0)
    campaign.update_attributes(status: Campaign.statuses[:active])
    campaign.save(validate: false)
    puts "----- Campaña \"#{campaign.name}\" en curso, fecha alcanzada de comienzo: #{campaign.start_date.to_date} -----"
    updated += 1
  end
end

puts "--- CAMPAÑAS ACTUALIZADAS: #{updated}   ---"
puts "====== ACTUALIZACIÓN COMPLETADA            ======"