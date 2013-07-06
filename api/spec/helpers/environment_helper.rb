def set_environment (environment)
  Rails.stub(env: ActiveSupport::StringInquirer.new(environment))
end