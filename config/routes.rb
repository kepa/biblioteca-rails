Rails.application.routes.draw do
  resources :books
  devise_for :users
  get 'static/home'

  root "static#home"
end
