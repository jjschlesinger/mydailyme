class CommentsController < ApplicationController

  def create
    if request.xhr? and request.post?
      if params[:comment_text].length > 0
      collapse = false
      if request.post?
      	collapse = true
      end 
      @subscription = Subscription.find params[:id]
      @subscription.me.comments << Comment.create(:user_id => session['user_id'], :message => params[:comment_text])

      dontCollapse = false

      #@result = @me.comments.to_json
      #render :layout => false
      render :partial => "subscriptions/comments", :locals => { :subscription => @subscription }, :layout => false
      end
    else
      redirect_to '/'
    end
  end
  
  def destroy
  	@comment = Comment.find params[:id]
  	@comment.destroy 
  end
end
