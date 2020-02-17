Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get '/information' => 'information#show'

  #development route for map

  root to: 'information#index'

  # User routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/user' => 'users#show'
  delete '/user' => 'users#destroy'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  # Post routes
  resources :posts do
    resources :replies
  end

  # Information routes
  resources :information

  # Private messaging routes
  resources :conversations do
    resources :messages
   end

end
