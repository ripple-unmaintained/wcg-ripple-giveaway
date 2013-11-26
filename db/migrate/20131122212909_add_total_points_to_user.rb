class AddTotalPointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_points, :integer, limit: 8
  end
end
