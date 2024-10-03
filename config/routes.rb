Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :usersbackoffice do
    post "users/sign_up", to: "users#sign_up"
  end
end
