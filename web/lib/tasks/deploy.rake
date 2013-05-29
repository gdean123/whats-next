desc "Deploy to Heroku"
task :deploy do
  Dir.chdir "#{Rails.root}/.." do
    `git subtree push --prefix web heroku master`
  end
end