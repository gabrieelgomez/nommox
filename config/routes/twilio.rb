namespace :twilio do
  post 'call',         to: 'calls#call'
  post 'connect/:to',  to: 'calls#connect'
  post 'record',       to: 'calls#record'
  post  'accessToken', to: 'calls#access_token'
end
