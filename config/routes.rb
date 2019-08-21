Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :theaters, only: :index
  resources :products do
    resources :reviews, only: [:new, :create, :edit, :destroy, :update]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
