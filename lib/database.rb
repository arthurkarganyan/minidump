class Database
  DUMP_FOLDER = "dumps"

  attr_reader :name, :db_instance, :host

  def initialize(name, db_instance)
    @name = name
    @db_instance = db_instance
  end

  def timestamp
    DateTime.now.strftime('%Y.%m.%d.%H.%M.%S.%L')
  end

  def dump!
    new_filename = "#{name}.#{self.class.name}.#{timestamp}.dump.gz"
    file_path = "#{new_filename}"
    `#{dump_cmd(file_path)}`
    `tar czf #{new_filename} dump`
    `rm -r dump`
    path = ENV['RCLONE_CONFIG']
    f = File.open(path).read.split("\n").map(&:strip).select { |i| i[0] != '#' }
    swift_storage_name = f[0][1..-2]
    cmd = "rclone --config #{path} copy #{file_path} #{swift_storage_name}:#{name}.#{self.class.name}"
    App.logger.info("Running: #{cmd}")
    stdout, stderr, status = Open3.capture3(cmd)
    App.logger.info stdout
    App.logger.info stderr

    `rm #{file_path}`
  end

end
