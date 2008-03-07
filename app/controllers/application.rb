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
      redirect_to new_session_path
    else
      true
    end
  end
  
end
