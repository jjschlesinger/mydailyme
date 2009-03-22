class CommentsController < ApplicationController

skip_before_filter :verify_authenticity_token, :is_authed, :only => ['create']
before_filter :authenticate, :only => ['create']

	def index
		@me = Me.find(params[:me_id])
	end
	
  def create
  	breakpoint
  	if request.post?
    	
      #if params[:comment_text].length > 0
      collapse = false
      if request.post?
      	collapse = true
      end 
     @subscription = Subscription.find params[:id]
     breakpoint
     @subscription.me.comments << Comment.create!(:user_id => session['user_id'], :message => params["comment_text_#{@subscription.id}"])
     @subscription.me.updated_at = Time.now
     @subscription.me.save

	  dontCollapse = false

	  #@result = @me.comments.to_json
	  #render :layout => false
	  #render :partial => "subscriptions/comments", :locals => { :subscription => @subscription }, :layout => false
	  
      
    end
    
    rescue ActiveRecord::RecordInvalid => @error_msg
      	#render :partial => "subscriptions/comments", :locals => { :subscription => @subscription, :error_message => e.record.errors.full_messages.join(", ").sub("Message ", "") }, :layout => false, :status => 444
  end

end
