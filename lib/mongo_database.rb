class MongoDatabase < Database
  def dump_cmd(file_path)
    "mongodump --host=#{db_instance.host} --db=#{name} --gzip --archive=#{file_path}"
  end
end
