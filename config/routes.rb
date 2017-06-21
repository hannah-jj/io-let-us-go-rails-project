Rails.application.routes.draw do
  root 'main#index', as: 'home'
  devise_for :users
  resources :users, only: [:show]
  resources :events

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
