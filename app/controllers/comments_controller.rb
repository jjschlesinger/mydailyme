class CommentsController < ApplicationController

  def create
    if request.xhr? and request.post?
      @me = Me.find params[:id]
      @me.comments << Comment.create(:user_id => session['user_id'], :message => params[:comment_text])
      render :partial => "comments"
    else
      redirect_to '/'
    end
  end
end
