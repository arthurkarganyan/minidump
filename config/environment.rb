require "bundler/setup"
require 'logger'
require 'open3'

Bundler.require(:default)

class App
  def self.logger
    @logger ||= Logger.new(STDERR)
  end
end

require_relative '../lib/database.rb'
require_relative '../lib/postgres_database.rb'
require_relative '../lib/mongo_database.rb'

