Rails.application.routes.draw do
    devise_for :users

  root'home#new'
  get 'home/new' => 'home#new'
  get 'home/top' => 'home#top'
  get 'search/search'

  resources :users,only: [:index, :show, :edit, :update, :withdraw] do
    resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :posts, only: [:index, :show, :edit, :new, :create, :update, :destroy] do
    resource :thanks, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
    resource :tags, only: [:create, :destroy]
   end
end
