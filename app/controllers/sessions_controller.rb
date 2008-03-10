class SessionsController < ApplicationController
  skip_before_filter :is_authed
  layout 'mes'
  # GET /sessions/new
  def new
    @user = User.new
  end

  # POST /sessions
  # POST /sessions.xml
  def create
    
    @user = User.authenticate(params[:user][:login], params[:user][:password])
    if @user.nil?
      flash[:notice] = 'Login failed.'
      render :action => "new"
    else
      session['user_id'] = @user.id
      flash[:notice] = 'Login successful.'
      if session['return_url'].nil?
        redirect_to(subscriptions_path)
      else
        redirect_to(session['return_url'])  
      end
      
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    session['user_id'] = nil
    session['return_url'] = nil
    redirect_to(new_session_path)
  end
end
