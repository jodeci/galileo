class ContentToPost < ActiveRecord::Migration[5.0]
  def change
    rename_table :contents, :posts
  end
end
