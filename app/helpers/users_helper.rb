module UsersHelper

  def is_match?(user_preference, match_parameter)
    user_preference == match_parameter
  end

  def is_favorite?(user, match)
    user.favorites.find_by(match_id: match.id) ? true : false
  end
end
