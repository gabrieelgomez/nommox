namespace :letters do
  get 'get_letter/:country_id', to: 'letters#get_letter'
end
