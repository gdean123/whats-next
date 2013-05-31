desc "Deploy to Heroku"
task :deploy do
  Dir.chdir "#{Rails.root}/.." do
    `git subtree push --prefix web heroku-web master`
    `heroku run rake db:migrate --app engage-me`
  end
end