Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root "frontend/pages#index"

  scope module: :frontend do
    resources :posts, only: [:index, :show]
    get "posts/taglist/:name", to: "posts#taglist", as: :posts_taglist
  end

  namespace :dashboard do
    get "/", to: "pages#index"
    resources :posts
    get "posts/taglist/:name", to: "posts#taglist", as: :posts_taglist

    resources :images
    get "images/taglist/:name", to: "images#taglist", as: :images_taglist

    resources :tags, only: [:index, :edit, :update, :destroy]
  end
end
