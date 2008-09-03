class AddEnableComments < ActiveRecord::Migration
  def self.up
    add_column :mes, :enable_comments, :boolean
    Me.update_all("enable_comments = 1")
  end

  def self.down
    remove_column :mes, :enable_comments
  end
end
