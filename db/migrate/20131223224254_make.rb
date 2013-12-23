class Make < ActiveRecord::Migration
  def up
		change_column(:claims, :xrp_disbursed, :decimal)
  end

  def down
		change_column(:claims, :xrp_disbursed, :integer)
  end
end
