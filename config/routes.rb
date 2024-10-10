Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :usersbackoffice do
    post "users/sign_up", to: "users#sign_up"
    resources :users, only: [ :index, :show, :destroy, :update ]
    resources :departments, only: [ :create, :index, :show, :destroy, :update ]
  end
  match "*unmatched", to: "application#route_not_found", via: :all
end
