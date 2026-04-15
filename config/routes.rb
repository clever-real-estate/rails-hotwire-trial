Rails.application.routes.draw do
  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: {
      sessions: "users/sessions"
    }

  root "photos#index"
end
