namespace :airlines do
  get   '/',                     to: 'show#index'
  get   '/:airline_id',          to: 'show#show'
  post  '/create',               to: 'create#create'
  patch '/:airline_id/update',   to: 'update#update'
  get   '/:query/search',        to: 'search#find_airline'
  get   '/:query/filter',        to: 'search#filter_airlines'
end
