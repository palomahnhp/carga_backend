puts "--- Comienzo de encriptación de ids de puestos ---"

updated = 0

Position.where("slug is null or slug = ''").each do |position|
  position.update_attributes!(slug: Digest::SHA1.hexdigest("#{position.id}"))
  updated +=1
end

puts "===== MODIFICADOS =====> #{updated} ======="
puts "===== PUESTOS TOTALES => #{Position.count} ====="