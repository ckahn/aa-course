NewsReader::Application.routes.draw do
  get "users/new"
  resources :users
  namespace :api do
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index]
    end
  end



  resource :session
  # root to: "sessions#new"
  root to: "static_pages#index"
end
