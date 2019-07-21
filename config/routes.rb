Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :products do
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
