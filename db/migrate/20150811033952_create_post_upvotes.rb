class CreatePostUpvotes < ActiveRecord::Migration
  def change
    create_table :post_upvotes do |t|
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_upvotes, :users
    add_foreign_key :post_upvotes, :posts
  end
end
