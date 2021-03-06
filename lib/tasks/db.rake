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
  desc "Normalize 'any_answer' field in units"
  task norm_answered_trackings: :environment do
    load(Rails.root.join("db", "norm_answered_trackings.rb"))
  end
  desc "Update campaigns status by date"
  task update_campaigns_status: :environment do
    load(Rails.root.join("db", "update_campaigns_status.rb"))
  end
end