Rails.application.routes.draw do
  root 'main#index', as: 'home'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :create, :edit, :update] 


  resources :event_users

  resources :comments

  resources :events do
    resources :itineraries, only: [:show, :index, :edit, :new]
    resources :comments, only: [:show, :index, :edit, :new]
    collection do
      get :popular
    end
  end

  resources :itineraries

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
