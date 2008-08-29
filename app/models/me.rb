require 'digest/sha1'

class Me < ActiveRecord::Base
    belongs_to :user
    has_one :section1, :class_name => "MeSection", :conditions => "me_sections.section_type = 1"
    has_one :section2, :class_name => "MeSection", :conditions => "me_sections.section_type = 2"
    has_one :section3, :class_name => "MeSection", :conditions => "me_sections.section_type = 3"
    has_one :section4, :class_name => "MeSection", :conditions => "me_sections.section_type = 4"
    has_one :section5, :class_name => "MeSection", :conditions => "me_sections.section_type = 5"
    has_one :section6, :class_name => "MeSection", :conditions => "me_sections.section_type = 6"
    has_many :me_sections
#    has_many :sections, :through => :me_sections
    has_many :subscriptions, :include => 'me', :conditions => 'mes.subscribe_token = subscriptions.subscription_token'
    has_many :comments
    
    def validate_auth(email, auth)
        true_auth = Digest::SHA1.hexdigest(email + subscribe_token)
        if auth == true_auth
            true
        else
            false
        end
    end
    
    def generate_auth(email)
        Digest::SHA1.hexdigest(email + subscribe_token)
    end
    
    def self.generate_token
        Digest::SHA1.hexdigest(Time.now.to_f.to_s)
    end
end
