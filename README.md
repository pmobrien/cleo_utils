# Cleo Utils

## clean_installer.rb

cleans up an ubuntu or red hat box after running the efss installer on it

- uninstalls and removes couchbase and related directories
- removes the vltrader and unify repo directories
- drops the vltrader database and creates a new, empty one with the same name

this should be ran from inside the actual box

the mysql2 gem is required:

```shell
sudo gem install mysql2
```

you might see this issue:

http://stackoverflow.com/questions/3608287/error-installing-mysql2-failed-to-build-gem-native-extension
  
the first answer should solve it

If you see an error about missing mkmf, the following command should fix it:

```shell
sudo apt-get install ruby-dev
```

###usage:
  
```shell
ruby clean_installer.rb path
```
  
- *path* is the directory containing /vltrader and /unifyrepo
  
- *path* is optional and defaults to /vagrant if it's not there

## copy_efss_files.rb

a quick and dirty copy of the files required to "refresh" a vltrader install with your working files (frontend and back)

this should not be used to replace vagrant provision, but rather as an alternative to use when a full provision is not necessary

###usage:

```shell
ruby copy_efss_files.rb repo_path vltrader_path
```
  
- *repo_path* is the top level of the EFSS git repo
  
- *vltrader_path* is the top level of the vltrader install

## upload_maven.rb

uploads all vltrader jars to the nexus artifact repository

ignores secureshare jars since those already get put into nexus via CI

###usage:

```shell
ruby upload_maven.rb directory url version
```
  
- *directory* is the location of the /Versalex/lib folder on your filesystem
  
- *url* is the url of the nexus repository you wish to upload to
  
- *version* is the version that you want these jars to be tagged with (ex: 5.1b2-SNAPSHOT)
