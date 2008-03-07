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
      render :action => "new"
    else
      session['user_id'] = @user.id
      flash[:notice] = 'Login successful.'
      redirect_to(:controller=>'subscriptions')
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    session['user_id'] = nil
    redirect_to('/')
  end
end
