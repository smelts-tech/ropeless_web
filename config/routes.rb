Rails.application.routes.draw do

  resources :fishers

  devise_for :users

  root to: "dashboard#index"

end
