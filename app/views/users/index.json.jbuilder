json.array!(@users) do |user|
  json.extract! user, :id, :login, :full_name, :password_digest, :role, :groups
  json.url user_url(user, format: :json)
end
