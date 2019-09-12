namespace :twilio do
  post 'call',                 to: 'calls#call'
  post 'connect/:to',          to: 'calls#connect'
  post 'record',               to: 'calls#record'
  get  'get_record/:call_sid', to: 'calls#get_record'
  get  'accessToken',          to: 'calls#access_token'
  get  'chatAccessToken',      to: 'chat#access_token'
end
