namespace :carousel do
  get    '/get_texts',                               to: 'carousel_configuration#index',   as: :texts
  get    '/add_texts',                               to: 'carousel_configuration#new',     as: :new_text
  post   '/create_text',                             to: 'carousel_configuration#create',  as: :create_text
  get    '/edit_text/:carousel_configuration_id',    to: 'carousel_configuration#edit',    as: :edit_text
  patch   '/update_text/:carousel_configuration_id', to: 'carousel_configuration#update',  as: :update_text
  delete '/destroy_text/:carousel_configuration_id', to: 'carousel_configuration#destroy', as: :destroy_text
end
