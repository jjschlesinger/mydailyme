require 'open-uri'
require 'uri'
require 'rubygems'
#require 'RMagick'
require 'aws/s3'


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
		send_to_s3
		image_path
	end
	
	def image_path
		"http://mdm_thumbnails_me#{@me_id}.s3.amazonaws.com/#{@img_name}"
	end

private	

	def download
		uri = URI.parse(@img_url)
		img = open(@img_url)
		@content_type = img.content_type
		@img_name = "me#{@me_id}_#{Time.now.to_f}"
		@new_img = "#{RAILS_ROOT}/tmp/#{@img_name}"

		Dir.chdir("#{RAILS_ROOT}/tmp/")	
		Dir["me#{@me_id}_*"].each do |f|
			File.delete(f)
		end
		open(@new_img,"wb") {|f|
			f.write img.read 
		}		
	end
	
	def resize
		`convert #{@new_img} -resize #{@width}x#{@height}\\> #{@new_img}`
		#thumb_geometry = "#{@width}x#{@height}"
		#img = Magick::Image.read(@new_img).first
		#if img.columns > @width && img.rows > @height
		#	img.change_geometry!(thumb_geometry) { |cols, rows, img2|
		#		img2.thumbnail!(cols, rows)
		#		img2.write(@new_img)
		#	}
		#end	
	end
	
	def send_to_s3
		
		AWS::S3::Base.establish_connection!(
						:access_key_id     => 'AKIAIAKTV5YMJK4G57XA',
						:secret_access_key => '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'
					)
		begin
			AWS::S3::Bucket.delete "mdm_thumbnails_me#{@me_id}", :force => true
		rescue
		end
		AWS::S3::Bucket.create "mdm_thumbnails_me#{@me_id}", :access => :public_read
		
		AWS::S3::S3Object.store(
			@img_name, 
			open(@new_img), 
			"mdm_thumbnails_me#{@me_id}",
			:content_type => @content_type,
			:access => :public_read)
		
	end

end
