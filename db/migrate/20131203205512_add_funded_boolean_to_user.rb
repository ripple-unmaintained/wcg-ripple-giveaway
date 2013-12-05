class AddFundedBooleanToUser < ActiveRecord::Migration
  def change
    add_column :users, :funded, :boolean, default: false
  end
end
