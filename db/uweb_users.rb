require 'uweb_update_api'

puts "--- Comienzo de autorización de usuarios en uWeb ---"

uwebapi = UwebUpdateApi.new("AncarRor")

User.all.each do |user|
  uwebapi.insert_profile(user)
  puts "\n"
end