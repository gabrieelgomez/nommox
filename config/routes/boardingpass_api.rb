namespace :boardingpass do
  get '/:departure_airport_code/:arrival_airport_code/:airline_code/search', to: 'search#filter'
end
