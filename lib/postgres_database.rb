class PostgresDatabase < Database
  def dump_cmd(file_path)
    "pg_dump #{name} --format c --host=#{host} --username=#{user} --password=#{password} > #{file_path}"
  end
end
