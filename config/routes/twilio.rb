namespace :twilio do
  post 'call',                                to: 'calls#call'
  post 'connect/:to',                         to: 'calls#connect'
  post 'record',                              to: 'calls#record'
  get  'get_record/:call_sid',                to: 'calls#get_record'
  get  'accessToken',                         to: 'calls#access_token'
  get  'chatAccessToken',                     to: 'chat#access_token'
  post 'message_received',                    to: 'chat#message_received'
  get  'get_unread_messages/:channel_sid',    to: 'chat#get_unread_messages'
  get  'remove_unread_messages/:channel_sid', to: 'chat#remove_unread_messages'
end
