Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "pages/home"
  get "pages/help"
  get "pages/contact"

  # Hoặc alias
  # get '/help', to: 'pages#help'
  # get '/contact', to: 'pages#contact'

  root "pages#home"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/account", to: "accounts#show", as: "account"
  resources :users, only: :show

end
