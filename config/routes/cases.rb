resources :cases do
  post '/status', action: :update_status
  post '/add_comment', action: :add_comment
end
