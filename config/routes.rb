Rails.application.routes.draw do
  resources :players, only: [:index, :new, :create, :edit, :update]
  resources :wagers, only: [:index]

  root to: "wagers#index"
end
