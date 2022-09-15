# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, :rentals
  devise_for :users, controllers: {sessions: 'users/sessions'}
  get 'static/home'

  root 'static#home'
end
