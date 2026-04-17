Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions"
    }

  root "photos#index"

  resources :photos, only: [:index] do
    get :filter_photos, on: :collection
    resource :like, only: [:create, :destroy], module: :photos
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
