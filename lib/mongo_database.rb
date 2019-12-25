class MongoDatabase < Database
  def dump_cmd(file_path)
    "mongodump --host=#{host} --db=#{name}"
  end
end
