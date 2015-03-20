require "pathname"

$directory = nil
$url = nil
$version = nil

def do_mvn(file_path)
  system(
    "mvn deploy:deploy-file " +
    "-Durl=" + $url + " " +
    "-DgroupId=com.cleo " +
    "-DartifactId=" + Pathname.new(file_path).basename.to_s.chomp(".jar") + " " + 
    "-Dversion=" + $version + " " +
    "-Dpackaging=jar " +
    "-Dfile=" + file_path + " " +
    "-DgeneratePom=true " +
    "-DrepositoryId=cleo_repo")
end

def print_error_message
  puts "Error parsing arguments."
  puts "Usage: "
  puts "  ruby upload_maven.rb directory url version"
  puts "    where directory is the local lib directory containing the jars to upload, "
  puts "    url is the url of the repository to upload to, "
  puts "    and version is the version that these jars will be in the repository"
end

def run
  Dir[$directory + "*"].each { |file|
    if(file.end_with? ".jar")
      do_mvn(file)
	  elsif(File.directory?(file) && !file.end_with?("secureshare"))
      Dir[file + "/*"].each { |sub_file|
        if(sub_file.end_with? ".jar")
          do_mvn(sub_file)
        end
      }
    end
  }
end

if(ARGV[0] == nil || ARGV[1] == nil || ARGV[2] == nil)
  print_error_message()
else
  $directory = ARGV[0]
  $url       = ARGV[1]
  $version   = ARGV[2]

  if(!$directory.end_with?("/"))
    $directory += "/"
  end

  run()
end
