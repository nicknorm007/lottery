json.array!(@players) do |player|
  json.extract! player, :id, :name, :position, :price, :team
  json.url player_url(player, format: :json)
end
