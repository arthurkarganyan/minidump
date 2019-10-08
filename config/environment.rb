require "bundler/setup"
require 'logger'
require 'open3'

Bundler.require(:default)

class App
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end

Dir['./config/initializers/*.rb'].each(&method(:require))
Dir['./lib/*.rb'].each(&method(:require))
