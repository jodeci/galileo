Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "pages#index"

  get :dashboard, to: "dashboard/pages#index"
  namespace :dashboard do
    resources :contents
    get "contents/taglist/:name", to: "contents#taglist", as: :contents_taglist
    resources :tags, only: [:index, :edit, :update, :destroy]
  end
end
