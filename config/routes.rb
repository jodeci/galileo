Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "pages#index"

  get :dashboard, to: "dashboard/pages#index"

  namespace :dashboard do
    resources :posts
    get "posts/taglist/:name", to: "posts#taglist", as: :posts_taglist

    resources :images
    get "images/taglist/:name", to: "images#taglist", as: :images_taglist

    resources :tags, only: [:index, :edit, :update, :destroy]
  end
end
