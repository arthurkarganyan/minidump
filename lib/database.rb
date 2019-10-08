class Database
  DUMP_FOLDER = "dumps"

  attr_reader :name, :db_instance

  def initialize(name, db_instance)
    @name = name
    @db_instance = db_instance
  end

  def timestamp
    DateTime.now.strftime('%Y.%m.%d.%H.%M.%S.%L')
  end

  def new_dump_path
    "#{DUMP_FOLDER}/#{new_filename}"
  end

  def dump!
    file_path = new_dump_path
    stdout, stderr, status = Open3.capture3(dump_cmd(file_path))
    App.logger.info stdout
    App.logger.info stderr

    cmd = "rclone --config #{ENV['RCLONE_CONFIG']} copy BackupStorage:Another/index.html 1.html"
    stdout, stderr, status = Open3.capture3(cmd)
    App.logger.info stdout
    App.logger.info stderr

  end

  def new_filename
    "#{self.class.name}.#{timestamp}.dump.gz"
  end
end
