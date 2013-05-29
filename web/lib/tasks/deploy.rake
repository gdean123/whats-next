desc "Deploy to Heroku"
task :deploy do
  Dir.chdir "#{Rails.root}/.." do
    `git subtree push --prefix web heroku-web master`
  end
end