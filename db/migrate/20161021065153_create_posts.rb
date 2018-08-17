class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :abstract, default: nil
      t.text :body
      t.string :slug
      t.integer :cover_image
      t.integer :status, default: 1
      t.boolean :featured, default: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
