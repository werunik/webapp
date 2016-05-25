Rails.application.routes.draw do

  require 'sidekiq/web'
  require 'sidekiq-statistic'
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#index'
  devise_for :users, controllers: {
                      registrations: 'users/registrations'
                    },
                    path: 'auth',
                    path_names: {
                      sign_in: 'login',
                      sign_out: 'logout',
                      password: 'secret',
                      confirmation: 'verification',
                      sign_up: 'signup'
                    }
  resources :projects, path: 'project'
end