desc "Deploy to Heroku"
task :deploy do
  Dir.chdir "#{Rails.root}/.." do
    `git subtree push --prefix api heroku-api master`
  end
end