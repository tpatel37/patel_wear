Rails.application.routes.draw do
  get "customers/edit"
  get "customers/update"
  # Devise routes for customers
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }

  # Devise + ActiveAdmin for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root path
  root to: "products#index"

  # Cart routes
  get 'cart', to: 'cart#show', as: 'cart'
  post '/cart/add/:id', to: 'cart#add', as: 'add_to_cart'
  delete '/cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
  patch '/cart/update_quantity/:id', to: 'cart#update_quantity', as: 'update_quantity_cart'
  get '/clear_cart', to: 'cart#clear', as: 'clear_cart'

  # Static pages
  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact

  # System health & PWA
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Orders
  get 'orders/confirm_payment', to: 'orders#confirm_payment', as: :confirm_payment
  resources :orders, only: [:new, :create, :show, :index, :edit, :update]

  # Payments
  resources :payments, only: [:new]

  # Products & Categories
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  # Customers
  resources :customers, only: [:edit, :update]
end
