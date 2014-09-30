class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :comments

      t.timestamps
    end
  end
end
