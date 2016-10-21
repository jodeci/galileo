Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "pages#index"

  get :dashboard, to: "dashboard/pages#index"
  namespace :dashboard do
    resources :contents
  end
end
