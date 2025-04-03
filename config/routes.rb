Rails.application.routes.draw do
  get "cart/show" 
  root to: "products#index"
  get "categories/show"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  
  get '/cart', to: 'cart#show', as: 'cart'
  post '/cart/add/:id', to: 'cart#add', as: 'add_to_cart'
  delete '/cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
  get '/clear_cart', to: 'cart#clear'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
end
