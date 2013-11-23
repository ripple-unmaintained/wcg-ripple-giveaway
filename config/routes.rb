WcgGiveaway::Application.routes.draw do
  namespace :api do
  	resources :users, only: :create
  	resources :stats, only: :index
    get 'stats/global', to: 'stats#global'
    resources :sessions, only: :create
    get 'session', to: 'sessions#show'
  end

  get 'register', to: 'users#new'
  get 'my-stats', to: 'stats#show'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root to: 'application#index'
end
