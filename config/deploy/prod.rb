set :branch,        :master
set :symfony_env,   'prod'

set :deploy_to,     fetch(:remote_path) + '/' + fetch(:domain) + '/' + fetch(:symfony_env)
fetch(:default_env).merge!(symfony_env: fetch(:symfony_env))

role :app, %w{www-data@example.com}
role :web, %w{www-data@example.com}

server fetch(:domain), user: fetch(:webserver_user), roles: %w{web app}