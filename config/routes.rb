Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index]
  root to: "static#dashboard"
  post '/add_friend', to: 'static#add_friend'
  post '/add_expense', to: 'expenses#add_expense'
  post '/settle_up', to: 'expenses#settle_up'
  get 'people/:id', to: 'static#person'
end
