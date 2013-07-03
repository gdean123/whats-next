namespace :servers do
  desc "Run two rails servers, one for dev and another for test"

  task :run_servers => :environment do
    pwd = Dir.pwd
    exec("cd #{pwd}; cd lib/tasks; ./server_launcher.sh")
  end

end