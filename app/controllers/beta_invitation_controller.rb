class BetaInvitationController < ApplicationController
  def new
	  @beta_invitation = BetaInvitation.new
  end

  def create
		@beta_invitation = BetaInvitation.new params[:beta_invitation]
		if @beta_invitation.save
			Notifier.deliver_beta_request_notification "josh@jschlesinger.net", @user.login
			flash[:notice] = 'You will be notified at the email provided once accepted'
			redirect_to new_session_path
		else
			render :action => "new"
		end
  end

end
