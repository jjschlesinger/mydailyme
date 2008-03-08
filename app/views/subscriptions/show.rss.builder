xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@subscription.me.title)
    xml.link("http://localhost:3000/subscriptions")
    xml.description(@subscription.me.title)
    xml.language('en-us')
    xml.image do
      xml.url("http://services.tucows.com/developers/wp-content/uploads/2007/10/bruce_on_rails.jpg")
      xml.title(@subscription.me.title)
      xml.link("http://localhost:3000/subscriptions")
    end    


    for me_section in @subscription.me.me_sections
      xml.item do
        if me_section.section.nil?
          xml.title("Soapbox")
        else
          xml.title(me_section.section.name)
        end
        xml.category()
        xml.description(me_section.value)
        xml.pubDate(me_section.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        #xml.link("http://localhost:3000/subscriptions/" + @subscription.id.to_s)
        #xml.guid("http://localhost:3000/subscriptions/" + @subscription.id.to_s)

      end
    end
  }
}