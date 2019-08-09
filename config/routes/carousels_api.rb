namespace :carousels, path: 'carousels' do
  get  '/',                     to: 'show#index'
  get  '/:carousel_id',         to: 'show#show'
  post '/create',               to: 'create#create'
  patch  '/:carousel_id/update',  to: 'update#update'
end
