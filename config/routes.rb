Rails.application.routes.draw do
  resource :session, only: [:create, :new, :destroy]
  resources :users, only: [:create, :new, :show]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
end
