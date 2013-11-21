WcgGiveaway::Application.routes.draw do
  namespace :api do
  	resources :users, only: :create
  	resources :stats, only: :index
  end

  get 'register', to: 'users#new'
  get 'my-stats', to: 'stats#show'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  post 'sessions', to: 'sessions#create'

  root to: 'application#index'
end
