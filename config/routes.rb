Rails.application.routes.draw do
  devise_for :users

  root "pages#index"

  namespace :dashboard do
    resources :contents
  end
end
