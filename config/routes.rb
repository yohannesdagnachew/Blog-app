Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show]
  end

  #   get '/users', to:'users#index', as: :users
  #   get '/users/:id', to:'users#show', as: :user
  get '/users/:user_id/posts/:id/comments', to: 'posts#new_comment', as: :new_comment
  post '/users/:user_id/posts/:id/comments/new_comment', to: 'posts#create_comment', as: :create_comment
  #   get '/users/:user_id/posts/:id', to:'posts#show', as: :user_post
  # post '/users/:user_id/posts/:id/comments', to:'posts#create_comment', as: :comments
  #  get '/users/:user_id/posts/:id/comments/new_comment',
  #   to:'posts#new_comment', as: :new_comment
  get '/users/:user_id/posts/:id/like', to: 'posts#like', as: :like
end
