OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret,
  scope: 'email,user_friends,basic_info,user_location,user_likes,friends_location,friends_interests,friends_relationship_details,friends_religion_politics,friends_likes', display: 'popup'
end
