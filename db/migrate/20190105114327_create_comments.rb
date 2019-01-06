class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter, null: false
      t.text :body, null: false
      t.references :article, foreign_key: true, null: false

      t.timestamps
    end
  end
end
