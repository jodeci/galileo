Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "pages#index"

  get :dashboard, to: "dashboard/pages#index"
  namespace :dashboard do
    resources :contents
    resources :tags, only: [:index, :edit, :update, :destroy]
  end
end
