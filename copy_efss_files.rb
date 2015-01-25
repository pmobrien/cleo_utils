require 'fileutils'

def print_error_message
  puts "Error parsing arguments."
  puts "Usage:"
  puts "  ruby copy_secure_share_jars.rb repo_path vltrader_path"
  puts "    where repo_path is the top level of the EFSS git repo"
  puts "    and vltrader path is the top level of the vltrader install for the files to be copied to"
end

def run
  @lib_path = $vltrader_path + "lib/secureshare"
  @webserver_path = $vltrader_path + "webserver"

  FileUtils.cp($repo_path + "server/SecureShare_API/target/SecureShare_API.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_Builders/target/SecureShare_Builders.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_Data/target/SecureShare_Data.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_m9_API/target/SecureShare_m9_API.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_POJO/target/SecureShare_POJO.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_Util/target/SecureShare_Util.jar", @lib_path)
  FileUtils.cp($repo_path + "server/SecureShare_WebServices/target/SecureShare_WebServices.jar", @lib_path)

  FileUtils.rm_rf(Dir.glob(@webserver_path + "/unify/*"))
  FileUtils.cp_r($repo_path + "client/dist/.", @webserver_path + "/unify")
end

if(ARGV[0] == nil || ARGV[1] == nil)
  print_error_message
else
  $repo_path = ARGV[0]
  $vltrader_path = ARGV[1]

  if(!$repo_path.end_with?("/"))
    $repo_path += "/"
  end

  if(!$vltrader_path.end_with?("/"))
    $vltrader_path += "/"
  end

  run
end
