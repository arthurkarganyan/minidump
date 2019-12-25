class DatabaseInstance
  attr_reader :host

  def initialize
    @host = ENV['MONGO_HOST'] || '127.0.0.1'
  end
end
