class CreateMeSections < ActiveRecord::Migration
  def self.up
    create_table :me_sections do |t|
      t.integer :section_id
      t.string :value
      t.string :other_name
      t.integer :me_id

      t.timestamps
    end
  end

  def self.down
    drop_table :me_sections
  end
end
