Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/help'
  get 'pages/contact'

  # Hoặc alias
  # get '/help', to: 'pages#help'
  # get '/contact', to: 'pages#contact'

  root 'pages#home'
end
