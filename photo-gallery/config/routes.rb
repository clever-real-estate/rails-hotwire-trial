Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :photos, only: %i[index] do
    resource :like, only: %i[create destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "photos#index"
end
