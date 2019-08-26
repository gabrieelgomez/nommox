namespace :twilio do
  get 'call', to: 'calls#call'
  post '/connect/:to', to: 'calls#connect'
end
