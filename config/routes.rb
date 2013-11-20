WcgGiveaway::Application.routes.draw do
  resources :members, only: :create do
    get :stats, on: :member
  end
  resources :claims, only: :update
end