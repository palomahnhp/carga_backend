puts "--- Comienzo de encriptación de ids de puestos ---"

Position.where('slug is null').each do |position|
  position.update_attributes(slug: Digest::SHA1.hexdigest("#{position.id}"))
end

puts "===== PUESTOS TOTALES => #{Position.count} ====="