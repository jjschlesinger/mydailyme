class SubscribersController < ApplicationController

	def index
		@subscriptions = Subscription.find_all_by_me_id 2, :include => :user
	end

end
