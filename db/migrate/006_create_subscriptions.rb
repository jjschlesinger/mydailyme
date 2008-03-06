class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :subscription_token
      t.integer :pos_x
      t.integer :pos_y
      t.boolean :collapsed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
