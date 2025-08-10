# Rails.application.routes.draw do
  
#   # get "products/home"
#   # get "products/about"
#   # root "products#login"
#   root "products#home"
# #  devise_for :users,
# #            path: '',
# #            path_names: {
# #              sign_in: 'login',
# #              sign_out: 'logout',
# #              registration: 'signup' 
# #            },
# #            controllers: {
# #              sessions: 'users/sessions',
# #              registrations: 'users/registrations'
# #            }

# devise_for :users, 
#              path: 'auth',  # This creates /auth/login, /auth/signup, etc.
#              controllers: {
#                sessions: 'web/sessions',           # For web login
#                registrations: 'web/registrations' # For web signup
#              }
           
           
#            resources :products
#            get "/home",to:"products#home"
#            get 'home/about/:id', to: 'products#about', as: 'product_about'

#   namespace :api do 
#     namespace :v1 do
#       resources :products
#        post 'auth/login', to: 'api/v1/sessions#create'
#         post 'auth/signup', to: 'api/v1/registrations#create'
#         delete 'auth/logout', to: 'api/v1/sessions#destroy'
#     end
#   end
#   # get "home/about",to:"products#about"
#   # get "home/edit",to:"products#about"
#   # get "/new", to:"products#new"
# # get '/new/:id', to: 'products#new', as: 'product_new'

# # get '/products/:id/about', to: 'products#about', as: 'product_about'




#   # get "/home",to:"pages#home"

#   # get "/products",to:"products#index"


#   # post "/products",to:"products#create"
  
#   # get "/product/:id",to:"products#show"

#   # get "/products",to:"products#index"

#   # get "/products/new",to:"products#new"
#   # get "/products" ,to:"products#create"
#   # get "/products/:id", to:"products#show"
#   # get "products/:id/edit",to:"products#edit" 
#   # patch "/products/:id",to:"products#update"
#   # put "/products/:id",to:"products#update"
#   # delete "/product/:id",to:"products#destroy"

#   # resources :prodcuts
#   # get "prodcuts"
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   # get "up" => "rails/health#show", as: :rails_health_check

#   # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
#   # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
#   # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

#   # Defines the root path route ("/")
#   # root "posts#index"
# end
# config/routes.rb
Rails.application.routes.draw do
  root "products#home"
  
  # Web routes
  devise_for :users, 
             path: 'auth',
             controllers: {
               sessions: 'web/sessions',
               registrations: 'web/registrations'
             }
  
  # API routes

require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

resources :products, only: [:index] do
  collection do
    post :import_from_api   # for importing via Sidekiq job
    get :home               # optional custom home route
  end
end



  namespace :api do 
    namespace :v1 do
      # Fix: Remove the extra api/v1 prefix from controller names
      devise_scope :user do
        post 'auth/login', to: 'sessions#create'      # This points to api/v1/sessions
        post 'auth/signup', to: 'registrations#create' # This points to api/v1/registrations  
        delete 'auth/logout', to: 'sessions#destroy'   # This points to api/v1/sessions
      end
      
      resources :products
    end
  end
  post '/products/import', to: 'products#import_from_api'

  # Web resources
  resources :products
  get "/home", to: "products#home"
  get 'home/about/:id', to: 'products#about', as: 'product_about'
end