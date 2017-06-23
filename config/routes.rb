Rails.application.routes.draw do
  root 'main#index', as: 'home'
  devise_for :users
  
  resources :users, only: [:show, :edit, :update] 

  # resources :events do
  # 	resources :comments, only: [:show, :index, :edit, :new]
  # end

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
