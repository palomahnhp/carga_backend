require 'uweb_update_api'
require 'uweb_authenticator'

puts "--- Comienzo de desautorización de usuarios en uWeb ---"

User.all.each do |user|
  uweb_auth = UwebAuthenticator.new()
  if uweb_auth.user_exists_by_dni?(user.document)
    puts "===> #{user.document} EXISTE EN UWEB <==="
    uwebapi = UwebUpdateApi.new("48417")
    uwebapi.remove_profile(uweb_auth.uweb_user_data)
    unless uweb_auth.errors.any? || uwebapi.errors.any?
      puts "===> DESAUTORIZADO EN UWEB <==="
    end
  else
    puts "===> #{user.document} NO EXISTE EN UWEB <==="
  end
  puts "\n"
end

puts "===== USUARIOS TOTALES => #{User.count} ====="