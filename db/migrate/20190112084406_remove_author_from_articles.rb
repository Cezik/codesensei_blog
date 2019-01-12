class RemoveAuthorFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :author, :string, null: false, default: 'Nieznany', index: true
  end
end
