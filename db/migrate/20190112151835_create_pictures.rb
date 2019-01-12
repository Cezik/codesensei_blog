class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :article, foreign_key: true, null: false
      t.string :title, null: false
      t.text :description
      t.string :image, null: false

      t.timestamps
    end
  end
end
