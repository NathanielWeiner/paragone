class AddTwitterAccessTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_oauth_token, :string
    add_column :users, :twitter_oauth_secret, :string
    add_index :users, [:twitter_oauth_token, :twitter_oauth_secret]
  end
end
