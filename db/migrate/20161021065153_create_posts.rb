class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :abstract
      t.text :body
      t.string :slug
      t.integer :cover_image
      t.string :status, default: "draft"
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
