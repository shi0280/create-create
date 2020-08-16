Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  resources :users, only: [:index, :edit, :show, :update] do
    collection do
      get 'search'
    end
  end
end
