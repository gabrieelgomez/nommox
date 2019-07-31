Rails.application.routes.draw do
  get 'provinces/index'
  get 'provinces/show'
  get 'provinces/new'
  get 'provinces/edit'
  get 'cities/index'
  root 'front#index'
  get  'main', to: 'pages#main'

  #sessions routes
  draw :sessions

  #users routes
  draw :users

  #carousel_configurations routes
  draw :carousel_configurations

  #case_causes routes
  draw :case_causes

  #locations routes
  draw :locations
end
