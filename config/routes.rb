Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  resources :posts, only: [:create, :destroy]
  resources :users, only: [:index, :edit, :show, :update] do
    collection do
      get 'search'
    end
  end

  namespace :following do
    resources :followeds, only: [:show] do
      resource :follow_requests, only:[:create, :destroy]
    end
  end
  
  namespace :followed do
    resources :followeds, only: [:show, :edit, :update] do
      resources :follow_okaies, only:[:index, :show, :destroy]
      post '/follow_requests/:id' => 'follow_requests#allow', as: 'allow'
      resources :follow_requests, only:[:index, :show, :destroy]
    end
  end
end
