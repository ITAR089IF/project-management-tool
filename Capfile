require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require "capistrano/rails"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"

install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
