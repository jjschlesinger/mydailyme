class CreateMes < ActiveRecord::Migration
  def self.up
    create_table :mes do |t|
      t.integer :user_id
      t.string :subscribe_token
      t.string :title
      t.text :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :mes
  end
end
