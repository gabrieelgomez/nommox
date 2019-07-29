Rails.application.routes.draw do
  root 'front#index'

  get 'signup', to: 'users#new',        as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post 'sessions/create'

  resources :users

  get 'main', to: 'pages#main'

  #carousel_configurations routes
  draw :carousel_configurations

  #case_causes routes
  draw :case_causes
end
