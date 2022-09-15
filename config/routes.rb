# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, :rentals
  devise_for :users, controllers: {sessions: 'users/sessions'}, :path_prefix => 'my'
  resources :users
  get 'static/home'

  root 'static#home'
end
