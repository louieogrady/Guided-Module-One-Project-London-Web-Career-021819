require 'bundler'
Bundler.require

require 'active_record'
require 'rake'
require 'discogs-wrapper'   # CHECK

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
