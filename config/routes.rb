Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  get "pages/home"
  get "pages/help"
  get "pages/contact"
  get '/logout', to: 'sessions#destroy'

  root "pages#home"
  
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  
  get "/account", to: "accounts#show", as: "account"

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships,only: %i(create destroy)
  get "users/:id/following", to: "users#following", as: :following
  get "users/:id/followers", to: "users#followers", as: :followers
end
