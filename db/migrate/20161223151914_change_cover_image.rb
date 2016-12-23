class ChangeCoverImage < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :cover_image, :text
  end
end
