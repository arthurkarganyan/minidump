class MongoDatabaseInstance < DatabaseInstance
  attr_reader :host, :client, :databases

  def initialize
    super
    @client = Mongo::Client.new("mongodb://#{host}:27017")
    @databases = client.list_databases.reject do |i|
      %w(admin config local undefined).include?(i['name'])
    end.map do |i|
      MongoDatabase.new(i['name'], self)
    end
  end

  def dump_all!
    databases.each(&:dump!)
  end
end
