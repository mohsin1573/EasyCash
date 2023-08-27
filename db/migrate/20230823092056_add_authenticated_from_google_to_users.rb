class AddAuthenticatedFromGoogleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :authenticated_from_google, :boolean
  end
end
  