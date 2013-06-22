Web::Application.routes.draw do
  resources :experiences, :only => [:show, :create, :destroy, :index]
end
