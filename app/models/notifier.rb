class Notifier < ActionMailer::Base
  def invite_notification(to_email, me)
    recipients to_email
    subject    "My Daily Me Invitation!"
    body       :me => me,
               :subscribe_url => url_for(:host => "mydailyme.net",
                                         :controller => "subscriptions",
                                         :action => "new",
                                         :auth => me.generate_auth(to_email),
                                         :id => me.id)
    from       me.user.login
    content_type "text/html"
  end
  
  def beta_request_notification(to_email, requested_by_email)
    recipients to_email
    subject    "My Daily Me - New Beta Request"
    body       :requested_by_email => requested_by_email
    from       "no-reply@mydailyme.net"
    content_type "text/plain"
  end
    
end
