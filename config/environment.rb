require 'bundler'
Bundler.require

require 'active_record'
require 'rake'
require 'discogs-wrapper'   # CHECK
require 'tty-prompt'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = Logger.new(STDOUT)
# ActiveRecord::Base.logger = false

require_all 'lib'
