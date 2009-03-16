class SubscribersController < ApplicationController

	def index
		@me = Me.find params[:me_id]
		@subscriptions = Subscription.find_all_by_me_id 2, :include => :user
	end

end
