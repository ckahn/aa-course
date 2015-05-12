Rails.application.routes.draw do
  resources :users, only: [:create, :show, :destroy, :update, :index] do
    resources :contacts, only: [:index]
    resources :comments, only: [:create, :index]
    resources :authored_comments, only: [:index]
  end

  resources :contacts, only: [:create, :show, :destroy, :update] do
    resources :comments, only: [:create, :index]
  end

  resources :contact_shares, only: [:create, :destroy]
  resources :comments, only: [:destroy]
end
