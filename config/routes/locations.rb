resources :countries
resources :cities
resources :provinces

get '/countries',  to: 'locations#countries'
get '/cities',     to: 'locations#cities'
post '/get_cities/:country_id', to: 'locations#get_cities'
post '/get_provinces/:city_id', to: 'locations#get_provinces'
