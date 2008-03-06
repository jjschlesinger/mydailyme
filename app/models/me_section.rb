class MeSection < ActiveRecord::Base
  belongs_to :section
  belongs_to :me
end
