WcgGiveaway::Application.routes.draw do
  namespace :api do
    post 'session/language', to: 'sessions#language'
    get 'session', to: 'sessions#show'
  end

  namespace :admin do
    get 'users', to: 'users#index'
		get 'users/by-ripple-address/:ripple_address', to: 'users#show'
		get 'users/by-username/:username', to: 'users#show'
  end

  get 'stats/username/:username', to: 'stats#username'
  get 'stats/member/:member_id', to: 'stats#show'
  get 'stats', to: 'stats#index'
    
  get 'register', to: 'users#new'

  root to: 'application#index'
end
