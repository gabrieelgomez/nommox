Rails.application.routes.draw do
  get 'search_airports/index'
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

  #airlines routes
  draw :airlines

  #flights routes
  draw :flights

  #search_airports routes
  draw :search_airports

  #routes for api
  namespace :api do
    namespace :v1 do
      draw :carousels_api

      draw :cases_api

      draw :airlines_api
    end
  end
end
