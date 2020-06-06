Rails.application.routes.draw do
  get 'session/new'
  get 'static_pages/home'
  get 'static_pages/help'
  get '/about', to: 'static_pages#about' 
  root 'static_pages#home'
  get '/sign_up', to: 'users#new' 
  get '/login', to: "session#new"
  post '/login', to: "session#create"
  delete '/logout', to: 'session#destroy'
  resources :users
  resources :account_activations, only: :edit
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
