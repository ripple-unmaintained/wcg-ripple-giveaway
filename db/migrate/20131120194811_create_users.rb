class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :username
      t.integer :member_id, limit: 8 # BIGINT
      t.string :verification_code
      t.boolean :eligible
      t.boolean :valid
      t.integer :points_claimed, limit: 8
      t.timestamps

      t.index :member_id, unique: true
    end
  end
end
