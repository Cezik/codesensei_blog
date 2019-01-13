class AddCommentableToCOmments < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :comments, :articles

    rename_column :comments, :article_id, :commentable_id
    add_column :comments, :commentable_type, :string, null: false, default: 'Article'

    add_index :comments, [:commentable_type, :commentable_id]

  end
end
