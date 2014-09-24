class AddFfpgToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :ffpg, :integer
  end
end
