Rails.application.routes.draw do
  root 'dashboard#index'
  get '/pricing',  to: 'dashboard#pricing'
  get '/product', to: 'dashboard#product'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  namespace :account do
    get '/dashboard', to: 'dashboard#index'
    get '/calendar', to: 'dashboard#calendar'
    resources :search, only: [:index], defaults: { format: :json }

    resource :profile, only: [:edit, :update]
    resources :workspaces do
      post :create_invitation_link
      resources :members, only: [:new, :create, :destroy] do
        collection do
          get :greeting_new_member
          post :create_thought_link
        end
      end
      resources :projects, except: [:index]
      member do
        get :list
      end
    end

    concern :commentable do
      resources :comments, only: [:create, :destroy]
    end

    resources :projects, only: [] do
      concerns :commentable
      resources :tasks, except: [:index] do
        member do
          put :move
          patch :complete
          patch :uncomplete
          patch :watch
          get :choose_assignee
          post :assign
          delete :unassign
          delete :remove_attachment
        end

        get :report, on: :collection, defaults: { format: :pdf }
      end
    end

    resources :tasks do
      concerns :commentable
    end
  end

  namespace :admin do
    resources :users, only: [] do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end
end
