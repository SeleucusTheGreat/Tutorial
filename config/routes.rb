Rails.application.routes.draw do
  get 'search', to: "search#index"
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get "/u/:id", to: "users#profile", as: "user"
  resources :posts do
    resources :comments
  end
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get "pages/home", to: "pages#home"
 
  root "pages#home"
end

