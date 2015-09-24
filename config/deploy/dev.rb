# Use the line below to be asked what branch to checkout to on each deployment to this environment
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch,        :master
set :symfony_env,   'dev'

set :deploy_to,     fetch(:remote_path) + '/' + fetch(:domain) + '/' + fetch(:application) + '/' + fetch(:symfony_env)
fetch(:default_env).merge!(symfony_env: fetch(:symfony_env))

role :app, %w{www-data@example.com}
role :web, %w{www-data@example.com}

server fetch(:domain), user: fetch(:webserver_user), roles: %w{web app}