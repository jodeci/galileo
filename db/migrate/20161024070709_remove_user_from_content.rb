class RemoveUserFromContent < ActiveRecord::Migration[5.0]
  def change
    remove_column :contents, :user_id
  end
end
