namespace :activities do
  post '/create', to: 'create#create'
  get  '/show/:identity',   to: 'show#show', constraints: { identity: /[0-z\.]+/ }
end
