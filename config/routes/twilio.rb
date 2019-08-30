namespace :twilio do
  post 'call', to: 'calls#call'
  post 'connect/:to', to: 'calls#connect'
  get  'access_token', to: 'calls#access_token'
end
