WcgGiveaway::Application.routes.draw do
  namespace :api do
  	resources :users, only: :create
  	resources :stats, only: :index
    get 'stats/global', to: 'stats#global'
    resources :sessions, only: :create
    post 'session/language', to: 'sessions#language'
    get 'session', to: 'sessions#show'
  end

  namespace :admin do
    get 'users', to: 'users#index'
		get 'users/by-ripple-address/:ripple_address', to: 'users#show'
		get 'users/by-username/:username', to: 'users#show'
  end

  get 'register', to: 'users#new'
  get 'my-stats', to: 'stats#show'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root to: 'application#index'
end
