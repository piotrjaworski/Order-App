Rails.application.routes.draw do
  root 'page#index'

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  resources :orders
  resources :restaurants

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/order_history', to: 'orders#history', as: 'orders_history'

end
