require 'uweb_update_api'
require 'uweb_authenticator'

puts "--- Comienzo de autorización de usuarios en uWeb ---"

if ENV["DG"]
  dg_codes = ENV['DG'].split(',')
  users = User.where(position_id: Position.select(:id).where(unit_id: Unit.select(:id).where(cod_dir: dg_codes)))
  puts "\n===> Autorizando usuarios de la DG #{ENV['DG']}, #{users.count} usuarios."
else
  users = User.all
  puts "\n===> Autorizando todos los usuarios de la BBDD."
end

users.each do |user|
  uweb_auth = UwebAuthenticator.new()
  if uweb_auth.user_exists_by_dni?(user.document)
    puts "===> #{user.document} EXISTE EN UWEB <==="
    uwebapi = UwebUpdateApi.new("48417")
    uwebapi.insert_profile(uweb_auth.uweb_user_data)
    unless uweb_auth.errors.any? || uwebapi.errors.any?
      puts "===> AUTORIZADO EN UWEB <==="
    end
  else
    puts "===> #{user.document} NO EXISTE EN UWEB <==="
  end
  puts "\n"
end

puts "===== USUARIOS AUTORIZADOS => #{users.count} ====="