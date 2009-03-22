require 'open-uri'
require 'uri'
require 'rubygems'
require 'RMagick'

class MeImage

	def initialize(w, h, me_id, img_url)
		@width = w
		@height = h
		@me_id = me_id
		@img_url = img_url		
	end
	
	def grab_image
		download
		resize
		@new_img_relative
	end
	
	def image_path
		@new_img_relative
	end

private	

	def download
		token = Time.now.to_f.to_s
		me_images_dir = "me_images"
		me_images_root = "#{RAILS_ROOT}/public/#{me_images_dir}"
		Dir.mkdir(me_images_root) unless File.exist?(me_images_root)
		uri = URI.parse(@img_url)
		path = uri.path.split("/")
		img_name = path[path.length - 1]
		img = open(@img_url)
		img_ext = get_extension(img.content_type)
		@new_img = "#{me_images_root}/me#{@me_id}_#{token}#{img_ext}"
		@new_img_relative = "/#{me_images_dir}/me#{@me_id}_#{token}#{img_ext}"
		Dir.chdir(me_images_root)	
		Dir["me#{@me_id}_*"].each do |f|
			File.delete(f)
		end
		open(@new_img,"wb") {|f|
			f.write img.read 
		}		
	end
	
	def resize
		thumb_geometry = "#{@width}x#{@height}"
		img = Magick::Image.read(@new_img).first
		if img.columns > @width && img.rows > @height
			img.change_geometry!(thumb_geometry) { |cols, rows, img2|
				img2.thumbnail!(cols, rows)
				img2.write(@new_img)
			}
		end	
	end
	
	def get_extension(content_type)
		
		case content_type
			when "image/jpeg"
				".jpg"
			when "image/gif"
				".gif"
			when "image/png"
				".png"				
			else
				raise "invalid content type"
		end			
	end

end
