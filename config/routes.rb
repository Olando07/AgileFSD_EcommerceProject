Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  # Create new Order, show order, show order, show index with order history
  get "/checkout", to: "orders#new"
  resources :orders, only: [ :create, :show, :index ]

  # Show Cart with add, update, delete and clear
  resource :cart, only: [ :show ], controller: 'cart' do
    post "add/:product_id", to: "cart#add", as: "add"
    patch "update/:product_id", to: "cart#update", as: "update"
    delete "remove/:product_id", to: "cart#remove", as: "remove"
    delete "clear", to: "cart#clear", as: "clear"
  end

  # Signup and create user
  get "/signup", to: "users#new"
  resources :users, only: [ :create ]

  # Index and show page for products
  resources :products, only: [ :index, :show ]

  # Sessions for login/logout
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
end
