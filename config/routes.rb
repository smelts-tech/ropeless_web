Rails.application.routes.draw do

  resources :fishers
  resources :devices
  resources :device_uploads, controller: "device_upload"
  resources :location_search, controller: "location_search"

  devise_for :users

  root to: "dashboard#index"

end
