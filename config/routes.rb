Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :usersbackoffice do
    post "users/sign_up", to: "users#sign_up"
    resources :users, only: [ :index, :show ]
  end
  match "*unmatched", to: "application#route_not_found", via: :all
end
