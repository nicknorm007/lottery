json.array!(@accounts) do |account|
  json.extract! account, :id, :username, :firstname, :lastname, :email, :comments
  json.url account_url(account, format: :json)
end
