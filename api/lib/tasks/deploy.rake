namespace :deploy do
  desc "Deploy to staging api server on Heroku"
  task :staging do
    deploy app: "engage-me-api-staging", remote:"heroku-api-staging"
  end

  desc "Deploy to production api server on Heroku"
  task :production do
    deploy app: "engage-me-api", remote:"heroku-api-production"
  end

  def deploy(options)
    Dir.chdir "#{Rails.root}/.." do
      `git subtree push --prefix api #{options[:remote]} master`
      `heroku run rake db:migrate --app #{options[:app]}`
    end
  end
end