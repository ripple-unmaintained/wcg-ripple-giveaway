class AddRolledOverToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :rolled_over, :boolean, default: false
  end
end
