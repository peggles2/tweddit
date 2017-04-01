class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  
  def get_friends
    friends = []
    tweets.each do |tweet|
      friends << tweet.like
    end
    friends.flatten.uniq
  end
  
  def get_frenemies
    frenemies = []
    tweets.each do |tweet|
      frenemies << tweet.dislike
    end
    frenemies.flatten.uniq
  end
  
  def get_karma
    friends         = get_friends
    total_friends   = get_friends.count
    total_frenemies = get_frenemies.count
    karma_score     = total_friends - total_frenemies
  end
end
