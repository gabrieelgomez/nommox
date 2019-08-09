namespace :airlines do
  get  '/',                     to: 'show#index'
  get  '/:airline_id',          to: 'show#show'
  post '/create',               to: 'create#create'
  patch  '/:airline_id/update', to: 'update#update'
end
