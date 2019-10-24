namespace :users do
  get   '/',                to: 'show#index'
  get   '/:user_id',        to: 'show#show'
  post  '/create',          to: 'create#create'
  patch '/:user_id/update', to: 'update#update'
end

get '/user/get_cases', to: 'users/show#cases'
