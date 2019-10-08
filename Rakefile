require './config/environment.rb'

task :dump_all do
  fail "No RCLONE_CONFIG provided" unless ENV['RCLONE_CONFIG']
  fail "No MONGO_HOST provided" unless ENV['MONGO_HOST']
  fail "File at RCLONE_CONFIG not exist" unless File.exists? ENV['RCLONE_CONFIG']

  MongoDatabaseInstance.new.dump_all!
end
