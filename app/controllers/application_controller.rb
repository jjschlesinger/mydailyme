# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :is_authed

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '07a5d45a26903156f5cc3120b41314c8'
  
  def is_authed
    if session['user_id'].blank?
      #if user_id not set then check for token
      if !cookies[:token].blank?
        u = User.find_by_session_hash(cookies[:token])
        if !u.nil?
          session['user_id'] = u.id
          return true
        end        
      end
      session['return_url'] = request.request_uri
      if is_m
      	redirect_to new_m_session_path
      else
      	redirect_to new_session_path
      end
    else
      return true
    end
  end
  
  def is_m
  	if request.request_uri == "/m" || request.request_uri[0..2] == "/m/"
  		true
  	else
  		false
  	end
  end
  
  def authenticate
  	
    case request.format
    when Mime::ATOM, Mime::RSS
      authenticate_or_request_with_http_basic('Project Me') do |username, password|
        session['user_id'] = User.authenticate(username, password).id
        if session['user_id'].nil?
          false
        else
          true
        end
      end
    when Mime::XML, Mime::JS
    		return true unless session['user_id'].nil?
    		breakpoint
        user = CGI.unescape(params[:user])
        pass = CGI.unescape(params[:pass])
        u = User.authenticate_api(user, pass)
        if u.nil?
          session['user_id'] = nil
          false
        else
          session['user_id'] = u.id
          true
        end      
    else
      is_authed
    end
  end  
  
end
