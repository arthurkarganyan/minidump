require "bundler/setup"
require 'logger'
require 'open3'

Bundler.require(:default)

class App
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end

autoload :Database, '../lib/database'
autoload :PostgresDatabase,  '../lib/postgres_database'
autoload :MongoDatabase, '../lib/mongo_database_database'

