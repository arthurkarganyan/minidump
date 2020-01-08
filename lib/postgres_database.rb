class PostgresDatabase < Database
  def dump_cmd(file_path)
    "PGPASSWORD=\"#{password}\" pg_dump #{name} --format c --host=#{host} --username=#{user} > #{file_path}"
  end
end
