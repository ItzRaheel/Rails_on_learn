Rails.application.routes.draw do
  
  # get "products/home"
  # get "products/about"
  # root "products#login"
  root "products#home"
  
  resources :products

  
  devise_for :users

  
  get "/home",to:"products#home"
  # get "home/about",to:"products#about"
  # get "home/edit",to:"products#about"
  # get "/new", to:"products#new"
get 'home/about/:id', to: 'products#about', as: 'product_about'
# get '/new/:id', to: 'products#new', as: 'product_new'

# get '/products/:id/about', to: 'products#about', as: 'product_about'




  # get "/home",to:"pages#home"

  # get "/products",to:"products#index"


  # post "/products",to:"products#create"
  
  # get "/product/:id",to:"products#show"

  # get "/products",to:"products#index"

  # get "/products/new",to:"products#new"
  # get "/products" ,to:"products#create"
  # get "/products/:id", to:"products#show"
  # get "products/:id/edit",to:"products#edit" 
  # patch "/products/:id",to:"products#update"
  # put "/products/:id",to:"products#update"
  # delete "/product/:id",to:"products#destroy"

  # resources :prodcuts
  # get "prodcuts"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
