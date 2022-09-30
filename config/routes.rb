Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show]
  end

  get '/users/:user_id/posts/:id/comments', to: 'comment#new_comment', as: :new_comment
  post '/users/:user_id/posts/:id/comments/new_comment', to: 'comment#create_comment', as: :create_comment
  get '/users/:user_id/posts/:id/like', to: 'like#like', as: :like
end
