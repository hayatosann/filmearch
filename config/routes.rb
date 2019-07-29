Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :products do
    resources :reviews, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
