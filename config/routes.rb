Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get    "sign_in",  to: "sessions#new",     as: :sign_in
  post   "sign_in",  to: "sessions#create"
  delete "sign_out", to: "sessions#destroy", as: :sign_out

  resources :photos, only: :index do
    resource :like, only: %i[ create destroy ]
  end

  root "photos#index"
end
