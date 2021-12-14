# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :comments, only: %i[new create destroy]
  # Users routes
  resource :user_profile, only: %i[show edit update]
  get '/show_per_assign/:id', to: 'user_profiles#show_per_assign', as: 'user_profile_per_assign_tasks'
  get '/show_per_approve/:id', to: 'user_profiles#show_per_approve', as: 'user_profile_per_approve_tasks'
  get '/show_approved/:id', to: 'user_profiles#show_approved', as: 'user_profile_approved_tasks'
  get '/take_out_user/:id', to: 'user_profiles#take_out_user', as: 'take_out_user'
  put '/edit_ajax', to: 'user_profiles#edit_ajax', as: 'edit_ajax'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # Landing route
  get 'landing/without_house'
  get 'landing/landing_page'
  root to: 'landing#landing_page'

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
