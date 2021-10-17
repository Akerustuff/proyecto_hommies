# frozen_string_literal: true

Rails.application.routes.draw do
  # Users routes
  resources :user_profiles, only: %i[show]
  devise_for :users

  # Landing route
  get 'landing/index'
  root to: 'landing#index'

  # House routes
  resources :houses, only: %i[new create show]
  get 'join', to: 'houses#join'
  post 'join_house', to: 'houses#join_house'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
