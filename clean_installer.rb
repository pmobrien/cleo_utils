require "fileutils"
require "mysql2"

system("sudo dpkg -r couchbase-server")
system("sudo rm -rf /opt/couchbase")

FileUtils.rm_rf("/Users/patrick/Documents/test_boxes/MysqlVagrantBox/unifyrepo")
FileUtils.rm_rf("/Users/patrick/Documents/test_boxes/MysqlVagrantBox/vltrader")

@db_host = "0.0.0.0"
@db_user = "vltrader"
@db_pass = "vltrader"
@db_name = "vltrader"

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass)
client.query("DROP DATABASE IF EXISTS #{@db_name}")
client.query("CREATE DATABASE #{@db_name}")
client.close
