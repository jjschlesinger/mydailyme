require 'digest/sha1'

class User < ActiveRecord::Base
    has_many :subscriptions
    has_many :mes
    validates_presence_of :login, :message=>"Login is required"
    validates_format_of :login, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message=>"Login needs to be a valid email address"
    validates_uniqueness_of :login, :message=>"That login is already taken"
    validates_presence_of :password, :message=>"Password is required"
    validates_length_of :password, :minimum=>5, :too_short=>"? More like ass word! Try atleast %d characters"
    validates_confirmation_of :password
    
    attr_accessor :password, :password_confirmation, :session
    
    def password=(pass)
        @password = pass
        self.hashed_password = User.encrypt(@password)
    end
    
    def self.authenticate(login, pass)
      u = find(:first, :conditions=>["login = ?", login])
      return nil if u.nil?
      if User.encrypt(pass) == u.hashed_password
        return u
      else
        return nil
      end
    end
    
    def self.authenticate_api(login, pass)
      api_u = find(:first, :conditions=>["login = ?", login])
      breakpoint
      return nil if api_u.nil?
      if pass == api_u.hashed_password
        return api_u
      else
        return nil
      end
    end
    
    def display_name
      self.login[0, self.login.index('@')]
    end
  
    
protected
    
    def self.encrypt(pass)
      Digest::SHA1.hexdigest(pass)
    end
    
    def self.hash_session(login, password_hash)
      Digest::SHA1.hexdigest(login + password_hash)
    end
    
end
