require './config/environment.rb'

task :c do
  binding.pry
end

task :dump_all do
  fail "No RCLONE_CONFIG provided" unless ENV['RCLONE_CONFIG']
  fail "No MONGO_HOST provided" unless ENV['MONGO_HOST']
  MongoDatabaseInstance.new.dump_all!
end
