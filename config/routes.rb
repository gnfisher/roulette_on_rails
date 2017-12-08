Rails.application.routes.draw do
  resources :players, only: [:index, :new, :create, :edit, :update]
end
