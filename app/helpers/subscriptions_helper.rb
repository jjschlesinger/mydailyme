module SubscriptionsHelper
  def rss_description(format_me)
    if format_me.image_url.nil?
      desc_html = ""
    else
      desc_html = "<p><img src='#{format_me.image_url}' /></p>"
    end
    
    for ms in format_me.me_sections
      if ms.section.nil? && !ms.value.blank?
        desc_html = desc_html + "<p>Soapbox: #{ms.value}</p>"
      elsif !ms.value.blank?
        desc_html = desc_html + "<p>#{ms.section.name}: #{ms.value}</p>"  
      end
    end
    desc_html
  end
end
