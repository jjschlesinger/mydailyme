class CommentsController < ApplicationController

  def create
    if request.xhr? and request.post?
      @me = Me.find params[:id]
      @me.comments << Comment.create(:user_id => session['user_id'], :message => params[:comment_text])
      #@result = @me.comments.to_json
      #render :layout => false
      render :partial => "comment_list", :locals => { :comments => @me.comments }, :layout => false
    else
      redirect_to '/'
    end
  end
end
