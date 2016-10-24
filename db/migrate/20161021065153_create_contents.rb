class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title, null: false
      t.text :abstract
      t.text :body
      t.string :template
      t.string :cover_image
      t.string :status, default: "draft"

      t.timestamps
    end
  end
end
