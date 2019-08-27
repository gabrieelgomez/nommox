namespace :twilio do
  get 'call', to: 'calls#call'
  post 'connect/:to/call', to: 'calls#connect'
end
