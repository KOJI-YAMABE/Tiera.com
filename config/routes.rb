Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
  }

  root'home#top'
  get 'home/top' => 'home#top'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
    member do
      put 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    end
  end

  resources :posts do
    resource :thanks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resource :tags, only: [:create, :destroy]
  end
end
