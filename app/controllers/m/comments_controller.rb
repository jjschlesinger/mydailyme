class M::CommentsController < CommentsController
	layout 'm'
	
  def create
		if request.post?
			breakpoint
			@me = Me.find(params[:me_id])
			@me.comments << Comment.create!(:user_id => session['user_id'], :message => params[:comment][:message])
			@me.save
			redirect_to(m_subscriptions_path(:page => params[:page]))
		end
  end

end
