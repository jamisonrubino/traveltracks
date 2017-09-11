Rails.application.routes.draw do
  resources :songs
  resources :playlists, only: [:show, :create]
  resources :clients
  get '/auth/spotify/callback', to: 'clients#spotify'
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
