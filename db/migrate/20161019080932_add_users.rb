class AddUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string, null: false
    add_index :users, :username
  end
end
