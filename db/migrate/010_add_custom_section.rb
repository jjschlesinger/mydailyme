class AddCustomSection < ActiveRecord::Migration
  def self.up
    Section.create(:name=>"Custom")
    add_column :me_sections, :custom_name, :string
    
  end

  def self.down
    Section.find_by_name('Custom').destroy
    remove_column :me_sections, :custom_name
  end
end
