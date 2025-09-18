Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  ################
  #### USERS #####
  ################

  # list all users
  get "/users", to: "users#index"

  # show a specific user
  get "/users/:id", to: "users#show"

  # create a new user
  post "/users", to: "users#create"

  # update a specific user
  put "/users/:id", to: "users#update"
  patch "/users/:id", to: "users#update"

  # delete a specific user
  delete "/users/:id", to: "users#destroy"

  # delete all comments from a specific user
  delete "/users/:id/comments", to: "users#destroy_comments"

  ################
  #### POSTS #####
  ################

  # list all posts
  get "/posts", to: "posts#index"

  # show a specific post
  get "/posts/:id", to: "posts#show"

  # create a new post
  post "/posts", to: "posts#create"

  # update a specific post
  patch "/posts/:id", to: "posts#update"
  put "/posts/:id", to: "posts#update"

  # Delete a specific post
  delete "/posts/:id", to: "posts#destroy"

  ################
  ### Comments ###
  ################

  # list all comments
  get "/comments", to: "comments#index"

  # show a specific comment
  get "/comments/:id", to: "comments#show"

  # create a new comment
  post "/comments", to: "comments#create"

  # update a specific comment
  patch "/comments/:id", to: "comments#update"
  put "/comments/:id", to: "comments#update"

  # delete a specific comment
  delete "/comments/:id", to: "comments#destroy"
end
