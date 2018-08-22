class RemoveCarrierwave < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :file, :string
    remove_column :images, :exif, :text
  end
end
