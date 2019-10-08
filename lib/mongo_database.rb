class MongoDatabase < Database
  def dump_cmd(file_path)
    "mongodump --host=#{db_instance.host} --db=#{name}"
  end
end
