class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims, id: :uuid do |t|
      t.integer :member_id, limit: 8
      t.integer :rate, limit: 8
      t.integer :points, limit: 8
      t.integer :xrp_disbursed, limit: 8
      t.string :transaction_hash
      t.string :transaction_status

      t.timestamps
    end
  end
end
