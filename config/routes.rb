Rails.application.routes.draw do
  # root route for the marketplace home page
  root 'home#index'

  # routes for session management (login and logout)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # routes for forgot your password link (password resets)
  resources :password_resets, only: [:new, :create, :edit, :update]

  # route for the registration form
  get 'signup', to: 'registrations#new', as: :new_registration

  # routes for user registration (new and create)
  resources :registrations, only: [:new, :create]

  # routes for product details
  resources :products do
    member do
      post 'add_to_cart'
      post 'message_seller'
      post 'write_review'
    end
  end

  # routes for creating cart items
  resources :cart_items, only: [:create]

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
