class AddPrimaryKeyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :id, :primary_key
  end
end
