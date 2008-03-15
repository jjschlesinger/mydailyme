class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :me
  
  def self.find_last_y_pos(user_id)
    s = Subscription.find(:first, :conditions => "user_id = #{user_id} and pos_x = 0", :order => "pos_y DESC")
    if s.nil?
      0
    else
      s.pos_y
    end
  end
end
