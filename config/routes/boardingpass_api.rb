namespace :boardingpass do
  get '/:from/:to/:airline/search', to: 'search#filter'
end
