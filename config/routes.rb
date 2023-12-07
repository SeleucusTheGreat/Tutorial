Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get "/u/1", to: "users#profile", as: "user"
  resources :posts
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get "pages/home", to: "pages#home"
 
  root "pages#home"
end

