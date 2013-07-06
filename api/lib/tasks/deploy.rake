desc "Deploy to Heroku"
task :deploy do
  Dir.chdir "#{Rails.root}/.." do
    `git subtree push --prefix api heroku-api master`
    `heroku run rake db:migrate --app engage-me-api`
  end
end