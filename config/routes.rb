Rails.application.routes.draw do
  resources :posts

  root 'welcome#index'

  resource  :sessions, only: [:new, :create, :destroy]
  resource  :registrations, only: [:new, :create]
  resources :posts, only: [:index]
end
