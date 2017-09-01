namespace :db do
  desc "Authorize local users in uWeb"
  task users: :environment do
    load(Rails.root.join("db", "uweb_users.rb"))
  end
  desc "Deauthorize local users in uWeb"
  task users_deauth: :environment do
    load(Rails.root.join("db", "uweb_users_deauth.rb"))
  end
  desc "Encrypt position ids"
  task encrypt_positions: :environment do
    load(Rails.root.join("db", "encrypt_positions.rb"))
  end
end