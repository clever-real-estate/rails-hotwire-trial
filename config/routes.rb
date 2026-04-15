Rails.application.routes.draw do
  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: {
      sessions: "users/sessions"
    }

  root "photos#index"

  resources :photos, only: [:index] do
    resource :like, only: [:create, :destroy], module: :photos
  end
end
