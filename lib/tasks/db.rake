namespace :db do
  desc "Authorize local users in uWeb"
  task :users do
    load(Rails.root.join("db", "uweb_users.rb"))
  end
end