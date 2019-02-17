class CreateOauthProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :oauth_profiles do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :provider

      t.timestamps
    end
    add_index :oauth_profiles, [:provider, :uid]
  end
end
