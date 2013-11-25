class ChangeClaimRateToDecimal < ActiveRecord::Migration
  def change
  	change_column :claims, :rate, :decimal
  end
end
