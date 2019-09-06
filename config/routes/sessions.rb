
get '/signup', to: 'sessions#signup',  as: 'signup'
get '/login',  to: 'sessions#new',     as: 'login'
get '/logout', to: 'sessions#destroy', as: 'logout'

post '/sessions/create', to: 'session#create', as: 'create_session'
