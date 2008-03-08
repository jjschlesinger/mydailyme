xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Project Me Subscriptions")
    xml.link("http://localhost:3000/subscriptions")
    xml.description("Project Me Subscriptions")
    xml.language('en-us')

    for subscription in @subscriptions
      xml.item do
        xml.title(subscription.me.title)
        xml.category()
        xml.description(rss_description(subscription.me))
        xml.pubDate(subscription.me.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link("http://localhost:3000/subscriptions/" + subscription.id.to_s)
        xml.guid("http://localhost:3000/subscriptions/" + subscription.id.to_s)
        xml.image do
          xml.url("http://services.tucows.com/developers/wp-content/uploads/2007/10/bruce_on_rails.jpg")
          xml.title(subscription.me.title)
          xml.link("http://localhost:3000/subscriptions/" + subscription.id.to_s)
        end    

      end
    end
  }
}