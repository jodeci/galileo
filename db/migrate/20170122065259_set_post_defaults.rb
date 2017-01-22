class SetPostDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column_default :posts, :abstract, from: '', to: nil
  end
end
