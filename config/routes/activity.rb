namespace :activities do
  get  '/create/:identity', to: 'create#create'
  get  '/show/:identity',   to: 'show#show', constraints: { identity: /[0-z\.]+/ }
end
