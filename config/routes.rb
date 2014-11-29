Rails.application.routes.draw do
  root 'orders#index'

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :orders
  resources :restaurants
  resources :calls, only: [:create]
  resources :collects, only: [:new, :create]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/order_history', to: 'orders#history', as: 'orders_history'

end
