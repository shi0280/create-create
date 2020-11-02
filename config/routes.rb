Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  resources :posts, only: [:create, :destroy]
  resources :users, only: [:index, :edit, :show, :update] do
    collection do
      get 'search'
    end
    member do
      get :following, :followers, :users_tweets
    end
  end
  resources :relationships, only: [:create, :destroy]
end
