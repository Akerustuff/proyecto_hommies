# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comments, only: %i[new create destroy]
  # Users routes
  resource :user_profile, only: %i[show edit update]
  get '/take_out_user/:id', to: 'user_profiles#take_out_user', as: 'take_out_user'
  devise_for :users

  # Landing route
  get 'landing/index'
  root to: 'landing#index'

  # House routes
  resources :houses, only: %i[new create show destroy]
  get 'join', to: 'houses#join'
  post 'join_house', to: 'houses#join_house'
  get 'leave_house', to: 'houses#leave_house'
  # Task routes
  resources :tasks
  get 'finish_task/:id', to: 'tasks#finish_task', as: 'finish_task'
  get 'reject_task/:id', to: 'tasks#reject_task', as: 'reject_task'
  get 'approve_task/:id', to: 'tasks#approve_task', as: 'approve_task'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
