resources :cases do
  post '/status', action: :update_status
  post '/add_comment', action: :add_comment
  post '/associate', action: :add_asesor, as: :add_asesor
end
