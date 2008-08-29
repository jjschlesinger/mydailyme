class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :me_id
      t.string :message, :limit => 1000

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
