get "products/new", to: "products#new"

Rails.application.routes.draw do
  devise_for :customers
  root "home#index"

  resources :categories, only: [:index, :show] do
    resources :products, only: [:show]
  end
  resources :products do
  collection do
    get :sale
    get :new
    get :recent
  end
end

  resources :products, only: [:index]
end