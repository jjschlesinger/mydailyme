require 'cgi'

module ApplicationHelper
    def netvibes_feed_link(login)
        login = CGI.escape(login)
        return '<a href="http://www.netvibes.com/subscribe.php?feed=http%3A//' + CGI.escape(login) + '@me.projecttruck.net/subscriptions.rss" target="_blank"><img src="http://www.netvibes.com/img/add2netvibes.gif" border="none" width="91" height="17" alt="Add to Netvibes"  /></a>'
    end
end
