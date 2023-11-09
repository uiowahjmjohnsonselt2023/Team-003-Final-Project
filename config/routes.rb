Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'

  # root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # routes for forgot your password link (password resets)
  get '/password_resets/new', to: 'password_resets#new', as: 'new_password_reset'
  post '/password_resets', to: 'password_resets#create'
  get '/password_resets/edit/:id', to: 'password_resets#edit', as: 'edit_password_reset'
  patch '/password_resets/update/:id', to: 'password_resets#update', as: 'update_password_reset'

  # route for the registration form
  get 'signup', to: 'registrations#new', as: :new_registration

  # routes for user registration (new and create)
  resources :registrations, only: [:new, :create]

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
