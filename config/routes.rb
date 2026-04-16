Rails.application.routes.draw do
  devise_for :users

  root "photos#index"

  resources :photos, only: [:index] do
    resource :like, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check  
end
