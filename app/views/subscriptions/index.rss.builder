xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Project Me Subscriptions")
    xml.link("http://me.projecttruck.net/subscriptions")
    xml.description("Project Me Subscriptions")
    xml.language('en-us')
    if !@lastUpdated.nil?
      xml.lastBuildDate(@lastUpdated.me.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
    end
    

    for subscription in @subscriptions
      xml.item do
        xml.title(subscription.me.title)
        xml.category()
        xml.description(rss_description(subscription.me))
        xml.pubDate(subscription.me.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link("http://me.projecttruck.net/subscriptions/" + subscription.id.to_s)
        xml.guid(subscription.me.updated_at.to_f.to_s)
      end
    end
  }
}