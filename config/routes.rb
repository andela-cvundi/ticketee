Rails.application.routes.draw do

  get 'comments/create'

  namespace :admin do
    root 'application#index'
    resources :projects, only: [:new, :create, :destroy]
    resources :users do
      member do
        patch :archive
      end
    end
  end

  devise_for :users

  root 'projects#index'

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      member do
        post :watch
      end
    end
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
  end

  resources :attachments, only: [:show, :new]

  namespace :api do
    resources :projects, only: [] do
      resources :tickets
    end
  end
end
