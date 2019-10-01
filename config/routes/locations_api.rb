namespace :locations do
  get '/countries',             to: 'filter#countries'
  get '/cities/:country_id',    to: 'filter#get_cities'
  get '/provinces/:city_id',    to: 'filter#get_provinces'
end
