class Comment < ActiveRecord::Base
  belongs_to :me
  belongs_to :user
end
