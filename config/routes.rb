Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'orders#index'

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :orders
  resources :restaurants
  resources :calls, only: [:new, :create]
  resources :collects, only: [:create]
  resources :rates, only: [:create, :edit, :update]
  resources :products, only: [:create, :edit, :update, :show]

  get 'rate_products/new/:id', to: 'rates#new_product_rate', as: 'new_product_rate'
  get 'rate_restaurants/new/:id', to: 'rates#new_restaurant_rate', as: 'new_restaurant_rate'
  get 'profile/index'
  get 'products', to: 'products#index', as: 'products_index'
  get 'users', to: 'users#index', as: 'users_index'
  get 'users/:id', to: 'users#show', as: 'show_user'
  get 'search', to: 'application#search', as: 'search'
  get 'order_history', to: 'orders#history', as: 'orders_history'
  get 'your_profile', to: 'profile#index', as: 'user_profile'
  get 'order_stats', to: 'orders#stats', as: 'orders_stats'
  get 'rate_products', to: 'rates#rate_products', as: 'rate_products'
  get 'rate_restaurants', to: 'rates#rate_restaurants', as: 'rate_restaurants'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  match "/404" => "errors#error404", via: [:get, :post, :patch, :delete]
end
