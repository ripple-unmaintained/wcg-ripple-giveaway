WcgGiveaway::Application.routes.draw do
  namespace :api do
  	resources :users, only: :create do
    	get :stats, on: :member
  	end
  	resources :claims, only: :update
  end

  get 'sign_up', to: 'users#new'
  root to: 'application#index'
end
