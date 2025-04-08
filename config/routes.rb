Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "pages/home"
  get "pages/help"
  get "pages/contact"
  get '/logout', to: 'sessions#destroy'
  # Hoặc alias
  # get '/help', to: 'pages#help'
  # get '/contact', to: 'pages#contact'
  root "pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/account", to: "accounts#show", as: "account"
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i(new create edit update)
  resources :microposts, only: [:create, :destroy]
end
