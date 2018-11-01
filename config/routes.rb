Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  namespace :account do
    get '/dashboard', to: 'dashboard#index'
    resources :workspaces do
      resources :projects, except: [:index]
    end

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end
    resources :projects, only: [] do
      concerns :commentable
      resources :tasks, except: [:index] do
        member do
          put :move
        end
      end
    end

    resources :task do
      concerns :commentable
    end
  end
end
