Rails.application.routes.draw do
  
  # OAuth Login
  get '/auth/:provider/callback', to: 'sessions#create'
  
  #OAuth Login Failure
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  # Logout
  match 'logout', to: 'sessions#destroy', as: 'logout', via: [:get, :post]
  
  # custom route to check status of user job; render matches
  get 'render_matches', to: 'users#render_matches'
  
  # User Resource
  resources :users, except: [:index, :new] do
    resources :favorites, only: [:index, :create, :destroy]
    resources :matches, only: :show
  end

  # Root URL
  root 'public#index'
  
end
