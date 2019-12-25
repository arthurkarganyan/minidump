require "bundler/setup"
require 'logger'
require 'open3'

Bundler.require(:default)

class App
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end

autoload :Database, 'lib/database.rb'
autoload :PostgresDatabase,  'lib/postgres_database.rb'
autoload :MongoDatabase, 'lib/mongo_database_database.rb'

