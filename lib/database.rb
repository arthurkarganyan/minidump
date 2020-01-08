class Database
  DUMP_FOLDER = "dumps"

  attr_reader :name, :host, :user, :password

  def initialize(name:, host:, user:, password:)
    @name = name
    @host = host
    @user = user
    @password = password
  end

  def timestamp
    DateTime.now.strftime('%Y.%m.%d.%H.%M.%S.%L')
  end

  def dump!
    new_filename = "#{name}.#{self.class.name}.#{timestamp}.dump.gz"
    run_sh dump_cmd(new_filename)
    run_sh "tar czf #{new_filename} dump"
    run_sh "rm -r dump"
    path = ENV['RCLONE_CONFIG']
    f = File.open(path).read.split("\n").map(&:strip).select { |i| i[0] != '#' }
    swift_storage_name = f[0][1..-2]
    cmd = "rclone --config #{path} copy #{new_filename} #{swift_storage_name}:#{name}.#{self.class.name}"
    App.logger.info(cmd)
    stdout, stderr, status = Open3.capture3(cmd)
    App.logger.info stdout
    App.logger.info stderr

    run_sh "rm #{new_filename}"
  end

  def run_sh(cmd)
    App.logger.info cmd
    `#{cmd}`
  end

end
