Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  get "user_posts/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  ################
  #### USERS #####
  ################

  resources :users, only: [] do
    resources :posts, only: :index, controller: "user_posts"
  end


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

  ################
  #### Likes  ####
  ################
  resources :posts, only: [] do
    #POST /posts/:post_id/likes → LikesController#create
    resources :likes, only: [:create, :destroy, :index]
    resources :comments, only: [] do
      # POST /posts/:post_id/comments/:comment_id/likes → LikesController#create
      resources :likes, only: [:create, :destroy, :index]
    end
  end
end
