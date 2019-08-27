Rails.application.routes.draw do
  resources :todos do
    resources :items
  end

  post 'auth/login', to: 'authentication#authenticate', as: :auth
  post 'signup', to: 'users#create', as: :signup
end
