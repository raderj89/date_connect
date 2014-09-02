class SharedInterest < ActiveRecord::Base
  
  # Relations
  belongs_to :user
  belongs_to :match
end
