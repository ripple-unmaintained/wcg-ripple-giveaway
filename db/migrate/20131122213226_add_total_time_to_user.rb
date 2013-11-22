class AddTotalTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_time, :integer, limit: 8
  end
end
