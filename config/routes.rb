Rails.application.routes.draw do
  root "home#index"

  resources :categories, only: [:index, :show] do
    resources :products, only: [:show]
  end

  resources :products, only: [:index]
end