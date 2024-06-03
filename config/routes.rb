Rails.application.routes.draw do
  get 'dashboards/show'
  devise_for :users
  resources :books
  resources :borrowings, only: %i[index create update destroy]

  namespace :api do
    namespace :v1 do
      resources :books
      resources :borrowings, only: %i[index create update destroy]
    end
  end

  get 'dashboard', to: 'dashboards#show', as: 'dashboard'

  root 'books#index'
end
