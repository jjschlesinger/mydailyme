require 'digest/sha1'

class Me < ActiveRecord::Base
    belongs_to :user
    has_many :me_sections
    has_many :sections, :through => :me_sections
    has_many :subscriptions
    
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
end
