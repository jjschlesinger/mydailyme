require 'cgi'

module ApplicationHelper
    def netvibes_feed_link(login)
        login = CGI.escape(login)
        return '<a href="http://www.netvibes.com/subscribe.php?feed=http%3A//' + CGI.escape(login) + '@me.projecttruck.net/subscriptions.rss" target="_blank"><img src="http://www.netvibes.com/img/add2netvibes.gif" border="none" width="91" height="17" alt="Add to Netvibes"  /></a>'
    end
    
    def ae_some_html(s)
        # converting newlines
        s.gsub!(/\r\n?/, "\n")
     
        # escaping HTML to entities
        s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
     
        # blockquote tag support
        s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>")
     
        # other tags: b, i, em, strong, u
        %w(b i em strong u).each { |x|
             s.gsub!(Regexp.new('&lt;(' + x + ')&gt;(.+?)&lt;/('+x+')&gt;',
                     Regexp::MULTILINE|Regexp::IGNORECASE), 
                     "<\\1>\\2</\\1>")
            }
     
        # A tag support
        # href="" attribute auto-adds http://
        s = s.gsub(/&lt;a.+?href\s*=\s*['"](.+?)["'].*?&gt;(.+?)&lt;\/a&gt;/im) { |x|
                '<a href="' + ($1.index('://') ? $1 : 'http://'+$1) + "\" target='_new'>" + $2 + "</a>"
              }
     
        # replacing newlines to <br> ans <p> tags
        # wrapping text into paragraph
        s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").
                gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>"
     
        return s      
    end
    
end
