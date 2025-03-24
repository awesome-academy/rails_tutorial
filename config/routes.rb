Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/help'
  get 'pages/contact'

  # Hoặc alias
  # get '/help', to: 'pages#help'
  # get '/contact', to: 'pages#contact'

  root 'pages#home'

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: :show
  
end
