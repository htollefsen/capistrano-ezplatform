# config valid only for current version of Capistrano
lock '3.3.5'

# Project specifics
set :application,       'mywebsite'
set :domain,            'example.com'
set :repo_url,          'git@github.com:htollefsen/mywebsite.git'
set :webserver_user,    'www-data'        # Default: www-data
set :remote_path,       '/var/www'      # No default


# The settings below shouldn't need any changes
set :scm, :git                          # Default: :git
set :format, :pretty                    # Default: :pretty
set :pty, false                         # Default: false
set :default_env, {}                    # Default: {}. Example: { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5                   # Default: 5
set :deploy_via, :remote_cache          # Default: :copy. Use :copy if the server dont have access to GitHub
set :tmp_dir, fetch(:remote_path) + '/' + fetch(:domain)

# Output
set :log_level, :info                   # Default: :debug. Options: info, debug

# eZPublish 5 specifics
set :app_path,                  "ezpublish"
set :web_path,                  "web"
set :vendor_path,               "vendor"
set :log_path,                  fetch(:app_path) + "/logs"
set :session_path,              fetch(:app_path) + "/sessions"
set :cache_path,                fetch(:app_path) + "/cache"
set :app_config_path,           fetch(:app_path) + "/config"
set :symfony_console_path,      fetch(:app_path) + "/console"
set :var_path,                  fetch(:web_path) + "/var"
set :linked_files,              [fetch(:app_config_path) + '/parameters.yml', fetch(:app_config_path) + '/ezpublish_dev.yml', fetch(:app_config_path) + '/ezpublish_prod.yml']
set :linked_dirs,               [fetch(:log_path), fetch(:session_path), fetch(:var_path)]
set :file_permissions_paths,    [fetch(:log_path), fetch(:cache_path), fetch(:session_path)]
set :permission_method,         :acl            # Default: false. Options: :chmod, :acl, :chgrp
set :use_set_permissions,       true
set :symfony_console_flags,     "--no-debug"
set :assets_install_path,       fetch(:web_path)
set :assets_install_flags,      '--symlink'
set :assetic_dump_flags,        ''
set :controllers_to_clear,      []   # Default: []
set :copy_files,                ['vendor']

# Composer
set :composer_install_flags,        '--no-interaction' # Default: '--no-dev --no-interaction --quiet --optimize-autoloader'
set :composer_roles,                :all
set :composer_working_dir,          -> { fetch(:release_path) }
set :composer_dump_autoload_flags,  '--optimize'
set :composer_download_url,         "https://getcomposer.org/installer"

# Rake::Task['deploy:updated'].prerequisites.delete('composer:install') # Uncomment this line to disable composer install

# Hooks
namespace :deploy do
  after :starting, 'composer:install_executable'
  after :updated, 'symfony:assets:install'
  after :updated, 'symfony:assetic:dump'
end
