Rails.application.routes.draw do
    get "/sign_in", to: "sessions#new"
    post "/sign_in", to: "sessions#create"
    delete "/sign_out", to: "sessions#destroy"

    resources :photos, only: [:index] do
        resource :like, only: [:create, :destroy]
    end

    root "photos#index"
 end
