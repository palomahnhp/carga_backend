require 'uweb_update_api'

puts "--- Comienzo de autorización de usuarios en uWeb ---"

uwebapi = UwebUpdateApi.new("AncarRor")

User.all.each do |user|
  uwebapi.insert_profile(user)
  puts "\n"
end

puts "===== USUARIOS TOTALES => #{User.count} ====="

# Recoger el dni
# Llamar a uWeb con dni como en Login Manager
# Traer datos entre ellos el user_id o user_key
# Llamar a API de Paloma con user_key => user_id que devuelve uweb
