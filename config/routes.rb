Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

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
    resources :thanks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resources :tags, only: [:create, :destroy]
  end
end
