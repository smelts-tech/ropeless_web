Rails.application.routes.draw do

  resources :fishers
  resources :devices
  resources :device_uploads, controller: "device_upload"
  resources :location_search, controller: "location_search"

  namespace :api do
    resources :device_uploads, controller: "device_upload"
  end

  namespace :admin do
    resources :access_requests, only: %w(index show update)
    resources :users, only: %w(index update)
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resource :dashboard, only: :show, controller: "dashboard"

  # for when users inevitably refresh the registration page
  get '/users', to: redirect("/users/sign_up")
  get '/thanks', to: "thanks#show"

  root to: "landing#show"
end
