class Notifier < ActionMailer::Base
  def invite_notification(to_email, me)
    recipients to_email
    subject    "Project Me Invitation!"
    body       :me => me,
               :subscribe_url => url_for(:host => "me.projecttruck.net",
                                         :controller => "subscriptions",
                                         :action => "new",
                                         :auth => me.generate_auth(to_email),
                                         :id => me.id)
    from       me.user.login
    content_type "text/html"
  end
end
