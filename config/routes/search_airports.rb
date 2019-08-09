namespace :airports do
  get '/:query/:search', to: 'search#filter_airports'
end
