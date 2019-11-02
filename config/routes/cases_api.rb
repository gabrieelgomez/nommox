namespace :cases do
  get   '/',                        to: 'show#index'
  get   '/:case_id',                to: 'show#show'
  post  '/create',                  to: 'create#create'
  patch '/:case_id/update',         to: 'update#update'
  patch '/:case_id/update_status',  to: 'update#update_status'
  post '/:case_id/add_test',        to: 'update#add_test'
  post '/add_companions_documents', to: 'update#companion_documents'
end
