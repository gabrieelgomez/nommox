Rails.application.routes.draw do
  get '/search_airports/index'
  root 'front#index'
  get  '/main', to: 'pages#main'
  get 'current_user', to: "users#get_current_user"

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

  #flights routes
  draw :letters

  #chat routes
  draw :chat

  #cases routes
  draw :cases

  #cases_status routes
  draw :case_status

  #smtp_settings routes
  draw :smtp_settings

  #routes for api
  namespace :api do
    namespace :v1 do
      draw :users_api
      draw :carousels_api
      draw :case_causes_api
      draw :airlines_api
      draw :cases_api
      draw :locations_api
      draw :search_airports
      draw :boardingpass_api
      draw :twilio
      draw :letters_api
      draw :activity
      draw :device
    end
  end
end
