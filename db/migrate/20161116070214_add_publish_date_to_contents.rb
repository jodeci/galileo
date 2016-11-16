class AddPublishDateToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :published_at, :datetime
  end
end
