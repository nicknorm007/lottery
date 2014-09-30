class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :price
      t.string :team

      t.timestamps
    end
  end
end
