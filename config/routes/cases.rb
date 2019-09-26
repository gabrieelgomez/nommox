resources :cases do
  post '/status', action: :update_status
end
