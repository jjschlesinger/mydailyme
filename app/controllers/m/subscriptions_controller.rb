class M::SubscriptionsController < SubscriptionsController
	layout 'm'
	
	def index
		subscriptions = Subscription.find(:all, :conditions=>['subscriptions.user_id = ? and subscriptions.me_id is not null',session['user_id']], :include => 'me', :order => 'mes.updated_at DESC')
		params[:page] = "1" if params[:page].blank? or params[:page].to_i < 1
		page_num = params[:page].to_i
		page_num = 1 if page_num > subscriptions.length or page_num < 1
		if page_num == subscriptions.length
			@next_page = 1
		else
			@next_page = page_num + 1
		end
		if page_num == 1
			@prev_page = subscriptions.length
		else
			@prev_page = page_num - 1
		end
		@current_me = subscriptions[page_num - 1].me
	end
end
