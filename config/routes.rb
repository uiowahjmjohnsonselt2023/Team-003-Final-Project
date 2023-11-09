Rails.application.routes.draw do

  # root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # route for the registration form
  get 'signup', to: 'registrations#new', as: :new_registration

  # routes for user registration (new and create)
  resources :registrations, only: [:new, :create]

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check

end
