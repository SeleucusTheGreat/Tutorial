Rails.application.routes.draw do
  authenticated :user, ->(user) { user.admin?} do
    get 'admin', to: "admin#index"
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_post'
  end
  get 'search', to: "search#index"
  get 'users/profile'
  get 'my_posts/:user_id', to: "posts#my_posts" , as: :my_posts
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

