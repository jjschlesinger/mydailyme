class AddMeImageThumbnail < ActiveRecord::Migration
  def self.up
		add_column :mes, :image_thumbnail, :string
  end

  def self.down
  	remove_column :mes, :image_thumbnail
  end
end
