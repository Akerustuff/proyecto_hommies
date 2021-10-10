# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :houses, only: %i[new create show]
  get 'landing/index'

  root to: 'landing#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
