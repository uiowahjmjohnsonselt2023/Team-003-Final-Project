R/*ails.application.routes.draw do
  #?+>-  root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # routes for forgot your password link (password resets)
  resources :password_resets, only: [:new, :create, :edit, :update]

  # r+4oute for the registration form
  get 'signup', to: 'registrations#new', as: :new_registration

  resources :sales do
    member do
      post 'create_review'
    end
  end
  # routes for user registration (new and create)
  resources :registrations, only: [:new, :create]
  
  # health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
