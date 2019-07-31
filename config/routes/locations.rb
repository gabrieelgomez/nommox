resources :countries
resources :cities
resources :provinces

get '/countries',  to: 'locations#countries'
get '/cities',     to: 'locations#cities'
get '/get_cities/:country_id', to: 'locations#get_cities'
