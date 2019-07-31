resources :airlines do
  get '/search/:query', action: :search, on: :collection
end
