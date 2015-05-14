Rails.application.routes.draw do
  resources :session, only: [:create, :new, :destroy]
  resources :users, only: [:create, :new, :show]
end
