Rails.application.routes.draw do
  get "carts/show"
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
resource :cart, only: [:show] do
  post "add/:product_id", to: "carts#add", as: :add
  patch "update/:product_id", to: "carts#update", as: :update
  delete "remove/:product_id", to: "carts#remove", as: :remove
end
end