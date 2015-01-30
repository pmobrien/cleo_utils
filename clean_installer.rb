require "fileutils"
require "mysql2"

def run
  @distro = File.read("/etc/issue")

  if(distro.include?("Ubuntu") || distro.include?("Red Hat"))
    system("sudo dpkg -r couchbase-server")
    system("sudo rm -rf /opt/couchbase")
  elsif(distro.include?("CentOS"))
    system("sudo rpm -e couchbase-server")
    system("sudo rm -rf /opt/couchbase")
  end

  FileUtils.rm_rf($directory + "unifyrepo")
  FileUtils.rm_rf($directory + "vltrader")

  @db_host = "0.0.0.0"
  @db_user = "vltrader"
  @db_pass = "vltrader"
  @db_name = "vltrader"

  client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
  client.query("DROP DATABASE IF EXISTS #{@db_name}")
  client.query("CREATE DATABASE #{@db_name}")
  client.close
end

$directory = if(ARGV[0] == nil) then
  "/vagrant/"
else
  ARGV[0]
end

run()
