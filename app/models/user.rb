class User < ActiveRecord::Base

  # Relations
  has_many :shared_interests, dependent: :delete_all
  has_many :matches, dependent: :delete_all
  has_many :favorites, dependent: :delete_all

  # Validations
  validates :match_location, length: { maximum: 255, message: "Location input is too long." }
  validates :match_religion, length: { maximum: 255, message: "Religion input is too long." }

  # OAuth
  def self.find_or_create_from_auth_hash(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  # Methods

  # Connect to Facebook API
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  # Get user Facebook friends
  def get_friends
    @friends ||= self.facebook.get_connections("me", "friends")
  end

  # Gets user Facebook likes
  def get_user_likes
    @likes_hash ||= self.facebook.get_connections("me", "likes", {limit: 500})
    @likes ||= []
    @likes_hash.each do |like|
      @likes << like["name"]
    end
    @likes
  end
end
