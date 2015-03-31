require "rubygems"
require "fileutils"
require "mysql2"

def remove_couchbase
  @distro = File.read("/etc/issue")

  if(@distro.include?("Ubuntu"))
    system("sudo dpkg -r couchbase-server")
  elsif(@distro.include?("CentOS") || @distro.include?("Red Hat"))
    system("sudo rpm -e couchbase-server")
  end

  system("sudo rm -rf /opt/couchbase")
end

def remove_vltrader
  FileUtils.rm_rf($directory + "unifyrepo")
  FileUtils.rm_rf($directory + "vltrader")
end

def remove_database
  @db_host = "0.0.0.0"
  @db_user = "vltrader"
  @db_pass = "vltrader"
  @db_name = "vltrader"

  client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
  client.query("DROP DATABASE IF EXISTS #{@db_name}")
  client.query("CREATE DATABASE #{@db_name}")
  client.close
end

def run
  remove_couchbase
  remove_vltrader
  remove_database
end

$directory = if(ARGV[0] == nil) then
  "/vagrant/"
else
  ARGV[0]
end

run
