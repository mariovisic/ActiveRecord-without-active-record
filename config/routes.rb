Rails.application.routes.draw do
  resources :posts

  root 'welcome#index'

  resources :sessions, only: [:new, :create]
  resources :posts, only: [:index]
end
