class InvitesController < ApplicationController
  layout 'mes'
  
  # GET /invites/new
  # GET /mes/1/invite
  def new
    @me = nil
    
    if params[:id].blank?
      @user = User.find(session['user_id'])
    else
      @me = Me.find(params[:id])
    end
  end

  # POST /invites
  def create
    #@me = Me.find(params[:me_id])
    #@to_email = params[:invite_email]
    #@auth = @me.generate_auth(@to_email)
    Notifier.deliver_invite_notification(params[:invite_email], Me.find(params[:me_id]))
  end
  
end
