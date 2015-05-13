Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    member do
      patch 'approve','deny'
    end
  end
end
