require 'open-uri'
require 'uri'

class BossApi
	def self.get_images(appid, query, format, start)
		query = URI.escape(query)
		url="http://boss.yahooapis.com/ysearch/images/v1/%22#{query}%22?appid=#{appid}&format=#{format}&start=#{start}"
		open(url) do |f|
			@result = f.read
		end
		
		@result
		
	end
end
