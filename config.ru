require './config/environment'
require_relative './app/models/user.rb'
require_relative './app/models/anime.rb'
require 'securerandom'
require 'sinatra/flash'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UsersController
use AnimeController
run ApplicationController
