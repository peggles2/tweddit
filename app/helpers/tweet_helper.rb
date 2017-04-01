module TweetHelper

  def get_selected(tweet_users)
    if tweet_users.present?
      selected = ""
      selected = (tweet_users.include? current_user.email) ? "selected" : ""
      return selected
    end
  end
end
