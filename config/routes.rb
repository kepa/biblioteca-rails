# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, :rentals
  devise_for :users, controllers: {sessions: 'users/sessions'}
  resources :users, :only => [:show,:index]
  get 'static/home'

  root 'static#home'
end
