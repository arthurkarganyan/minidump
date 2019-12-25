class PostgresDatabase < Database
  def dump_cmd(file_path)
    "pg_dump #{name} --format c --host=#{host} > #{file_path}"
  end
end
