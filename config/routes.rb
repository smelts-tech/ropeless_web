Rails.application.routes.draw do

  resources :fishers
  resources :device_uploads, controller: "device_upload"

  devise_for :users

  root to: "dashboard#index"

end
