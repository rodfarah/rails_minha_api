Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  # list all users
  get "/users", to: "users#index"

  # create a new user
  post "/users", to: "users#create"

  # show a specific user
  get "/users/:id", to: "users#show"

  # update a specific user
  put "/users/:id", to: "users#update"
  patch "/users/:id", to: "users#update"

  # delete a specific user
  delete "/users/:id", to: "users#destroy"
end
