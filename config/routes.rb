Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :borrowings, only: [:index, :create, :update, :destroy]

  namespace :api do
    namespace :v1 do
      resources :books
      resources :borrowings, only: [:index, :create, :update, :destroy]
    end
  end

  root 'books#index'
end
