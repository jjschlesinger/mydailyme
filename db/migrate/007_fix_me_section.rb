class FixMeSection < ActiveRecord::Migration
  def self.up
    remove_column :me_sections, :other_name
    add_column :me_sections, :section_type, :integer
    remove_column :me_sections, :value
    add_column :me_sections, :value, :string, :limit => 4000
  end

  def self.down
    add_column :me_sections, :other_name
    remove_column :me_sections, :section_type
    remove_column :me_sections, :value
    add_column :me_sections, :value
  end
end
