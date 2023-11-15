Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :postings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'my_postings', to: 'postings#my_postings', as: 'my_postings'


  # Defines the root path route ("/")
  get "up" => "rails/health#show", as: :my_app_health_check 
  root "users#index"
     
  
end
