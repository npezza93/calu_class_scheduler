json.array!(@users) do |user|
  json.extract! user, :id, :email, :admin, :advisor
  json.url user_url(user, format: :json)
end
