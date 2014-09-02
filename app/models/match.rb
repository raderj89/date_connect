class Match < ActiveRecord::Base
  
  # Relations
  belongs_to :user
  has_many :shared_interests, dependent: :delete_all

  # Methods

  def is_favorite?(user)
    user.favorites.find_by(match_id: self.id)
  end

  def favorite_id(user)
    id = user.favorites.find_by(match_id: self.id).id
    id? ? id : nil
  end
end
