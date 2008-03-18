xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    #xml.title(@subscription.me.title)
    xml.title("Project Me Subscription")
    xml.language('en-us')

    xml.item do
      xml.title(@subscription.me.title)
      xml.category()
      xml.description(rss_description(@subscription.me))
      xml.pubDate(@subscription.me.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      xml.link("http://me.projecttruck.net/subscriptions/" + @subscription.id.to_s)
      xml.guid("http://me.projecttruck.net/subscriptions/" + @subscription.id.to_s)
    end
  }
}