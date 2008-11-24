require 'open-uri'
require 'uri'
require 'rubygems'
require 'RMagick'

class MeImage

	def self.grab_image(me_id, img_url)
		width = 150
		height = 150
		thumb_geometry = "#{width}x#{height}"
		token = Time.now.to_f.to_s
		me_images_dir = "me_images"
		me_images_root = "#{RAILS_ROOT}/public/#{me_images_dir}"
		Dir.mkdir(me_images_root) unless File.exist?(me_images_root)
		uri = URI.parse(img_url)
		path = uri.path.split("/")
		img_name = path[path.length - 1]
		img_ext = img_name[img_name.rindex(".")..-1]
		img_name = "me#{me_id}_#{token}#{img_ext}"
		new_img = "#{me_images_root}/#{img_name}"
		new_img_relative = 	"/#{me_images_dir}/#{img_name}"
		Dir.chdir(me_images_root)	
		Dir["me#{me_id}_*"].each do |f|
			File.delete(f)
		end
		open(new_img,"wb") {|f|
			f.write open(img_url).read 
		}
		
		img = Magick::Image.read(new_img).first
		if img.columns > width && img.rows > height
			img.change_geometry!(thumb_geometry) { |cols, rows, img2|
				img2.thumbnail!(cols, rows)
				img2.write(new_img)
			}
		end
		new_img_relative
	end
end
