class FacebookMatcher
  attr_reader :user, :user_likes, :friends
  attr_accessor :matches, :friend_data, :shared_interests

  def initialize(user)
    @user = user
    @matches = {}
    @friend_data = {}
    @friends = @user.get_friends
    @user_likes = @user.get_user_likes
    @shared_interests = []
  end

  def get_friend_data
    friends.each do |friend|
      user.update(progress_bar: friend_data.keys.length)
      friend_info = user.facebook.get_object(friend["id"]) do |data|
        [data['id'], data['name'], data['gender'], data['location'], data['religion'], data['relationship_status']]
      end

      next if friend_info[2] != user.match_gender

      friend_data[friend_info[0]] = { name: friend_info[1],
                                      gender: friend_info[2],
                                      location: (friend_info[3].nil? ? "n/a" : friend_info[3]["name"]),
                                      religion: (friend_info[4].nil? ? "n/a" : friend_info[4]),
                                      relationship_status: friend_info[5].nil? ? "n/a" : friend_info[5],
                                      likes: [] }

      friend_likes = user.facebook.get_connections(friend_info[0], "likes", {limit: 500})
      
      friend_likes.each do |like|
        friend_data[friend_info[0]][:likes] << like["name"]
      end
    end
    calculate_matches
  end

  def calculate_matches
    friend_data.each do |id, attributes|
      matches[id] = 0

      if user.match_location == friend_data[id][:location]
        matches[id] += 20
      end

      if user.match_relationship_status == friend_data[id][:relationship_status]
        matches[id] += 20
      end

      if user.match_religion == friend_data[id][:religion]
        matches[id] += 10
      end
      
      shared_interests = user_likes & friend_data[id][:likes]

      case shared_interests.length
      when 1..2
        matches[id] += 10
      when 3..4
        matches[id] += 20
      when 5..6
        matches[id] += 30
      when 7..8
        matches[id] += 40
      when 9..10
        matches[id] += 45
      when shared_interests.length > 10
        matches[id] += 50
      end
    end
    
    save_top_matches
    user.update(job_status: 'finished')
  end

  def save_top_matches
    sorted = matches.sort_by { |id, score| score }.reverse.take(5)
    sorted.each do |id, score|
      match = user.matches.build(uid: id, match_percent: score)
      match.name = friend_data[id][:name]
      match.location = friend_data[id][:location]
      match.gender = friend_data[id][:gender]
      match.relationship_status = friend_data[id][:relationship_status]
      match.religion = friend_data[id][:religion]

      match.save
      save_shared_interests(match)
    end
  end

  def save_shared_interests(match)
    shared_interests = user_likes & friend_data[match.uid][:likes]
    shared_interests.each do |interest|
      match_interest = user.shared_interests.build(interest: interest)
      match_interest.match = match
      match_interest.save
    end
  end
end