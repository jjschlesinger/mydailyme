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
      if params[:stay_logged_in] == "1"
        @user.update_attribute(:session_hash, User.hash_session(@user.login, @user.hashed_password))
				#this will not work for TLD's like co.uk or an ip or multiple sub domains'
        parts = request.host.split "."
        if parts.length == 3
	        cookies[:token] = { :value => @user.session_hash, :domain => "#{parts[1]}.#{parts[2]}", :expires => Time.now.next_year }
	      else
	      	cookies[:token] = { :value => @user.session_hash, :domain => request.host, :expires => Time.now.next_year }
	      end
      end
            
      if session['return_url'].nil?
        if is_m
        	redirect_to(m_subscriptions_path)
        else
        	redirect_to(subscriptions_path)
        end
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
    cookies.delete(:token)
    redirect_to(new_session_path)
  end
end
