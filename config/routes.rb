# frozen_string_literal: true

Rails.application.routes.draw do
  # Users routes
  resource :user_profile, only: %i[show edit update]
  # put 'user_profile', to:'user_profile#update'
  devise_for :users

  # Landing route
  get 'landing/index'
  root to: 'landing#index'

  # House routes
  resources :houses, only: %i[new create show]
  get 'join', to: 'houses#join'
  post 'join_house', to: 'houses#join_house'
  get 'leave_house', to: 'houses#leave_house'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
