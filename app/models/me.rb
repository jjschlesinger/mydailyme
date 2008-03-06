require 'digest/sha1'

class Me < ActiveRecord::Base
    belongs_to :user
    has_many :me_sections
    has_many :sections, :through => :me_sections
    
    def validate_auth(subscriber_id, auth)
        true_auth = Digest::SHA1.hexdigest(subscriber_id.to_s + subscribe_token)
        if auth == true_auth
            true
        else
            false
        end
    end
end
