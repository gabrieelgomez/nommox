namespace :boardingpass do
  get '/:from/:to/:airline/search', to: 'search#filter'
  post '/parse', to: 'search#parse'
end
