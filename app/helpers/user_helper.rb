module UserHelper
  def get_tweets
    TweetRequest.where("zipcode = ? and service in (?)",current_user.zipcode,current_user.services.collect(&:name).collect(&:downcase)).order('id desc').limit(5)
  end
end
