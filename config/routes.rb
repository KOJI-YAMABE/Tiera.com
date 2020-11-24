Rails.application.routes.draw do
  devise_for :users

  root'home#top'
  get 'home/top' => 'home#top'
  get 'search/search'

  resources :users, only: [:index, :show, :edit, :update, :withdraw] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
    member do
      put 'users/withdraw' => 'users#withdraw'
    end
  end

  resources :posts do
    resource :thanks, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
    resource :tags, only: [:create, :destroy]
  end
end
