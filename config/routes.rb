Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  namespace :account do
    get '/dashboard', to: 'dashboard#index'
    resources :workspaces do
      resources :projects
    end

    resources :projects do
      resources :tasks, except: [:index] do
        member do
          put :move
        end
      end
    end
  end
  resources :comments, only: [:create, :destroy]
end
