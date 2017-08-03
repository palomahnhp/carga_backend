# config valid only for current version of Capistrano
lock '3.8.2'

def deploysecret(key)
  @deploy_secrets_yml ||= YAML.load_file('config/deploy-secrets.yml')[fetch(:stage).to_s]
  @deploy_secrets_yml[key.to_s]
end

set :rails_env, fetch(:stage)

set :rvm_ruby_string, :local        # use the same ruby as used locally for deployment

set :rvm1_ruby_version, "2.2.7"

before 'deploy', 'rvm1:install:rvm'  # install/update RVM
before 'deploy', 'rvm1:install:ruby' # install Ruby and create gemset (both if missing)

set :application, 'ancar_areas'
set :server_name, deploysecret(:server_name)
set :full_app_name, fetch(:application)
# If ssh access is restricted, probably you need to use https access
set :repo_url, 'https://dnacenta:Everis01@bitbucket.org/ancarga/carga_backend.git'

set :revision, `git rev-parse --short #{fetch(:branch)}`.strip

set :log_level, :info
set :pty, true
set :use_sudo, false

# set :linked_files, %w{config/database.yml config/secrets.yml}
# set :linked_dirs, %w{log tmp public/system public/assets}

set :keep_releases, 10

## Run test before deploy
# set :tests, ["spec"]

# Config files should be copied by deploy:setup_config
set(:config_files, %w(
  log_rotation
  database.yml
  secrets.yml
  unicorn.rb
))

#
namespace :deploy do
  # Check right version of deploy branch
  before :deploy, "deploy:check_revision"
  # Run test aund continue only if passed
  # before :deploy, "deploy:run_tests"
  # Compile assets locally and then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  # # Restart unicorn
  after 'deploy:publishing', 'deploy:restart'
  after 'deploy:restart', 'sidekiq:restart'
end


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
