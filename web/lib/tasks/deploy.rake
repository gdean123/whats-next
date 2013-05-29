desc "Deploy to Heroku"
task :deploy do
  `git subtree push --prefix web heroku master`
end