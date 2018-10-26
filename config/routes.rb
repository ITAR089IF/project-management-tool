Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  namespace :account do
    get '/dashboard', to: 'dashboard#index'
    resources :projects do
      resources :comments, only: [:new, :create, :update, :destroy]
      resources :tasks, except: [:index] do
        put '/:move', to: 'tasks#move', as: 'move'
        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end
end
