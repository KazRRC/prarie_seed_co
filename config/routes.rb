

Rails.application.routes.draw do
namespace :admin do
  root "dashboard#index"

  resources :products
  resources :categories
end
  devise_for :customers
  root "home#index"
  resources :categories, only: [:index, :show] do
    resources :products, only: [:show]
  end
  resources :products do
  collection do
    get :sale
    get :recent
    get :new_products
end

  resources :products, only: [:index]
end
end