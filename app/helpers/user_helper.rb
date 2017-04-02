module UserHelper
  def get_people(friends)
    users = ""
    friends.each do |user|
      users = users + " " + user + ","
    end
     users.chop
  end
  
  def get_karma(score)
    karma_message = ""
    if score > 0 && score < 5
      karma_message =  'Oh your karma is low, hiring Parissa will help'
    elsif score > 5 && score < 8 
      karma_message =  'Your karma is getting there, I suggest hiring Parissa to help it '
    elsif score > 8 && score < 10 
      karma_message =  'Great Karma! You can do even better with Parissa working with you'
    elsif score > 10
      karma_message =  'Namaste! You are the Karma master and worthy to have Parissa work with you'
    else
      karma_message = 'You are beyond hope!'
    end
    return karma_message
  end
end
