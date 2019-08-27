namespace :cases do
  get   '/',                       to: 'show#index'
  get   '/:case_id',               to: 'show#show'
  post  '/create',                 to: 'create#create'
  patch '/:case_id/update',        to: 'update#update'
  patch '/:case_id/update_status', to: 'update#update_status'
  post '/:case_id/add_test',       to: 'update#add_test'
end
