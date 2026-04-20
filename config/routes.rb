Rails.application.routes.draw do
  get    "/login",  to: "sessions#new",     as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :photos, only: [:index] do
    resources :likes, only: [:create], shallow: true
  end
  resources :likes, only: [:destroy]

  root "photos#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
