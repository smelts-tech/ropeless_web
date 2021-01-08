Rails.application.routes.draw do

  resources :fishers
  resources :devices
  resources :device_uploads, controller: "device_upload"
  resources :location_search, controller: "location_search"

  devise_for :users

  resource :dashboard, only: :show, controller: "dashboard"

  root to: "dashboard#show"
end
