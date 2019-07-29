json.extract! user, :id, :email, :name, :phone, :country, :city, :province, :created_at, :updated_at
json.url user_url(user, format: :json)
