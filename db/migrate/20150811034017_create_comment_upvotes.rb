class CreateCommentUpvotes < ActiveRecord::Migration
  def change
    create_table :comment_upvotes do |t|
      t.references :user, index: true
      t.references :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :comment_upvotes, :users
    add_foreign_key :comment_upvotes, :comments
  end
end
