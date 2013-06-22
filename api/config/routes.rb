Web::Application.routes.draw do
  resources :experiences, :only => [:show, :create, :destroy, :index]

  delete "clean_database" => "database_cleaner#clean_database" unless Rails.env.production?
end
