class ImageSearchController < ApplicationController
	def index
		#breakpoint
		if params[:format] == "html"
			format = "xml"
		else
			format = params[:format]
		end
		
		@result = BossApi.get_images "HwTLtK3V34H6EJK1TRWOMyHYty3qcx7HwXBX.KaqswR3A2i35mSZkyzLoPRS9SfeSjMjGdlm", params[:query], format, params[:start]    
		
		respond_to do |format|
      format.html do # index.html.erb
				render :layout => false
      end
      format.xml  do
        
        render :xml => @result
      end
      format.json do
        
        render :json => @result
      end
    end

	end

end
