json.array!(@players) do |player|
  json.extract! player, :id, :name, :position, :price, :team, :ffpg, :active
  json.url player_url(player, format: :json)
end
