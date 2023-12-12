Rails.application.routes.draw do
  # routes defined for user
  get '/user/:id', to: 'users#show'
  post '/signup', to: 'users#create'
  post '/signin', to: 'users#login'
  patch'/user/:id/update', to: 'users#update'
  delete '/signout/:id', to: 'users#logout'
  delete '/remove_account/:id', to: 'users#remove_account'
  
  # routes defined for users post
  get '/users/:user_id/posts/:id', to: 'posts#show'
  get '/users/:user_id/posts', to: 'posts#index'
  get '/all_posts', to: 'posts#all_posts'
  post '/users/:user_id/posts/create', to: 'posts#create'
  patch '/users/:user_id/posts/:id/update', to: 'posts#update'
  delete '/users/:user_id/posts/:id/destroy', to: 'posts#destroy'

end