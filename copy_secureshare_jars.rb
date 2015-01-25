require 'fileutils'

repo_path = "/Users/patrick/Documents/_code/EFSS"
lib_path = "/Users/patrick/Documents/_code/EFSS/server/TestServer/vltrader/lib/secureshare"
webserver_path = "/Users/patrick/Documents/_code/EFSS/server/TestServer/vltrader/webserver"

FileUtils.cp(repo_path + "/server/SecureShare_API/target/SecureShare_API.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_Builders/target/SecureShare_Builders.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_Data/target/SecureShare_Data.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_m9_API/target/SecureShare_m9_API.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_POJO/target/SecureShare_POJO.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_Util/target/SecureShare_Util.jar", lib_path)
FileUtils.cp(repo_path + "/server/SecureShare_WebServices/target/SecureShare_WebServices.jar", lib_path)

FileUtils.rm_rf(Dir.glob(webserver_path + "/unify/*"))
FileUtils.cp_r(repo_path + "/client/dist/.", webserver_path + "/unify")
