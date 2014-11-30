Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'profile/index'

  root 'orders#index'

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :orders
  resources :restaurants
  resources :calls, only: [:new, :create]
  resources :collects, only: [:create]

  get '/today_orders', to: 'orders#today_orders', as: 'today_orders'
  get '/order_history', to: 'orders#history', as: 'orders_history'
  get '/your_profile', to: 'profile#index', as: 'user_profile'
  get '/order_stats', to: 'orders#stats', as: 'orders_stats'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

end
