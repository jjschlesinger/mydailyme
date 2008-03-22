class StayLoggedIn < ActiveRecord::Migration
  def self.up
    add_column :users, :session_hash, :string
  end

  def self.down
    remove_column :users, :session_hash
  end
end
