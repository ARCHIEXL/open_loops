Rails.application.routes.draw do
  root "tasks#index"          # Now

  get "/inbox",   to: "tasks#inbox",   as: :inbox
  get "/archive", to: "tasks#archive", as: :archive

  resources :tasks do
    member do
      patch :toggle_complete
    end
  end
end
