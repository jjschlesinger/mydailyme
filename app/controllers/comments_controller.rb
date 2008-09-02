class CommentsController < ApplicationController

  def create
    if request.xhr? and request.post?
      #if params[:comment_text].length > 0
      collapse = false
      if request.post?
      	collapse = true
      end 
      @subscription = Subscription.find params[:id]
     @subscription.me.comments << Comment.create!(:user_id => session['user_id'], :message => params["comment_text_#{@subscription.id}"])
     

	  dontCollapse = false

	  #@result = @me.comments.to_json
	  #render :layout => false
	  #render :partial => "subscriptions/comments", :locals => { :subscription => @subscription }, :layout => false
	  
      
    end
    
    rescue ActiveRecord::RecordInvalid => @error_msg
      	#render :partial => "subscriptions/comments", :locals => { :subscription => @subscription, :error_message => e.record.errors.full_messages.join(", ").sub("Message ", "") }, :layout => false, :status => 444
  end
  
  def destroy
  	@comment = Comment.find params[:id]
  	@comment.destroy 
  end
end
