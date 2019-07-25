namespace :causes do
  get    '/get_case_causes',              to: 'case_cause#index',   as: :causes
  get    '/add_cause',                    to: 'case_cause#new',     as: :new_cause
  post   '/create_cause',                 to: 'case_cause#create',  as: :create_cause
  get    '/edit_cause/:case_cause_id',    to: 'case_cause#edit',    as: :edit_cause
  patch   '/update_cause/:case_cause_id', to: 'case_cause#update',  as: :update_cause
  delete '/destroy_cause/:case_cause_id', to: 'case_cause#destroy', as: :destroy_cause
end
