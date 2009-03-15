class AddPublicFlagToMe < ActiveRecord::Migration
  def self.up
    add_column :mes, :public, :boolean
  end

  def self.down
    remove_column :mes, :public
  end
end
