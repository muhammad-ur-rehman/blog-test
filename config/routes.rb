Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :posts do
    member do
      get 'follow', to: 'posts#follow'
      get 'unfollow', to: 'posts#unfollow'
    end
    resources :comments, only: [:create]
  end
end
