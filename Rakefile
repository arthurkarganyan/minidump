require './config/environment.rb'

task :dump do
  begin
    App.logger.info("Starting dumping...")
    fail "No ENV[DB_NAME] provided" unless ENV['DB_NAME']
    fail "No ENV[DB] provided" unless ENV['DB']
    fail "No ENV[DB_USER] provided" unless ENV['DB_USER']
    fail "No ENV[DB_PASSWORD] provided" unless ENV['DB_PASSWORD']
    fail "No ENV[RCLONE_CONFIG] provided" unless ENV['RCLONE_CONFIG']
    fail "No ENV[DB_HOST] provided" unless ENV['DB_HOST']
    fail "File at ENV[RCLONE_CONFIG] not exist" unless File.exists? ENV['RCLONE_CONFIG']

    clazz_name = if ENV['DB'] == 'postgres'
                   PostgresDatabase
                 elsif ENV['DB'] == 'mongo'
                   MongoDatabase
                 else
                   fail "Incorrect #{ENV['DB']} provided"
                 end

    clazz_name.new(host: ENV["DB_HOST"], name: ENV["DB_NAME"], user: ENV['DB_USER'], password: ENV['DB_PASSWORD']).dump!
  rescue StandardError => err
    App.logger.error(err)
  end
end
