class AddAuthorToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :author, :string, null: false, default: 'Nieznany', index: true
  end
end
