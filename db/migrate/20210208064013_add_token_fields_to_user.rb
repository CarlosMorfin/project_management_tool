class AddTokenFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login_token, :string
    add_column :users, :login_token_valid_until, :datetime
  end
end