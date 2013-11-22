class AddInitialRunTimeAndInitialPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :initial_run_time, :integer, limit: 8
    add_column :users, :initial_points, :integer, limit: 8
  end
end
