Rails.application.routes.draw do
  # routes defined for user
  get '/user', to: 'users#show'
  post '/signup', to: 'users#create'
  post '/signin', to: 'users#login'
  patch'/user/update', to: 'users#update'
  delete '/signout', to: 'users#logout'
  delete '/remove_account', to: 'users#remove_account'
  
  # routes defined for users post
  get '/posts/:id', to: 'posts#show'
  get '/posts', to: 'posts#index'
  get '/all_posts', to: 'posts#all_posts'
  post '/posts/create', to: 'posts#create'
  patch '/posts/:id/update', to: 'posts#update'
  delete '/posts/:id/destroy', to: 'posts#destroy'
end