Rails.application.routes.draw do
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get "pages/home", to: "pages#home"
 
  root "pages#home"
end

