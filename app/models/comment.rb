class Comment < ActiveRecord::Base
  belongs_to :me
  belongs_to :user
  validates_presence_of :message, :message=>"Please enter a comment"
  validates_length_of :message, :maximum => 1, :too_short => "Please enter a comment", :maximum => 1000, :too_long=>"Please limit your comment to %d characters"
end
