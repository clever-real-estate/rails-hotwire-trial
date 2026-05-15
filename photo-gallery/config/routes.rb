Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "photos#index"

  get  "/login",  to: "sessions#new",     as: :login
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :photos, only: [:index] do
    resources :likes, only: [:create, :destroy]
  end
end