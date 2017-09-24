Rails.application.routes.draw do
  resources :playlists, only: [:index, :show, :create]
  # resources :users
  get '/logout', to: 'users#logout'
  get '/auth/spotify/callback', to: 'users#spotify'
  post '/make_playlist', to: 'playlists#create'
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
