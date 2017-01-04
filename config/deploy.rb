lock '3.5.0'

require 'whenever/capistrano'

set :application, 'GCPM'
set :repo_url, 'git@github.com:Vizzuality/GCPM.git'

set :passenger_restart_with_touch, true

set :rvm_type, :auto
set :rvm_ruby_version, '2.3.1'
set :rvm_roles, [:app, :web, :db]

set :branch, 'master'
set :deploy_to, '~/gcpm'

set :keep_releases, 5

set :linked_files, %w{.env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db_backups public/downloads public/uploads}

set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:symlink:linked_files', 'deploy:symlink:linked_dirs', 'deploy:restart'
end
