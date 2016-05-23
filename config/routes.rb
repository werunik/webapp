Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  resources :projects, path: 'project'
end