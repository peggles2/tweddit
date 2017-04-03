class TweetController < ApplicationController
  before_action :authenticate_user!

  #List all the tweets
  def index
    @tweet   = Tweet.new
    @comment = Comment.new
    @tweets  = Tweet.all.order('created_at DESC')
    @friends = current_user.get_friends
  end

  #delete tweets 
  def destroy
    @tweet  = Tweet.find(params[:id])
    #make sure the user is the owner of the tweet
    user_id = @tweet.user.id 
    if user_id == current_user.id
      @tweet = Tweet.find(params[:id]).destroy
    else
      Rails.warn("The tweet does not belong to the user to delete")
    end
  end
 
  #add user email to like, or dislike. Check if already liked/disliked before adding the user 
  def vote
    id        = params[:id]
    @tweet    = Tweet.find(id)
    selection = params[:selection]
    #Check if the user already liked this tweet
    if (@tweet.like.present? and @tweet.like.include? current_user.email) or (@tweet.dislike.present? and @tweet.dislike.include? current_user.email)
      if selection == "up" 
        @tweet.like.delete(current_user.email)
      elsif selection == "down"
        @tweet.dislike.delete(current_user.email)
      end
    else
      if selection == "up" 
        @tweet.like = [] if !@tweet.like
        @tweet.like << current_user.email 
      elsif selection == "down"
        @tweet.dislike = [] if !@tweet.dislike
        @tweet.dislike << current_user.email
      end
    end
    @tweet.save!
  end

  #Add comment to a tweet  
  def create_comment
    comment  = params[:comment]
    tweet_id = comment[:tweet_id]
    @tweet   = Tweet.find(tweet_id)
    @comment = @tweet.comments.create(comment_params.merge(user_id: current_user.id))
    @comment = Comment.new
    
    redirect_to action: "index"
  end
  
  #Add a new tweet  
  def create
    tweet    = params[:tweet]
    message  = tweet[:message]
    @tweet   = current_user.tweets.create(tweet_params)
    @comment = Comment.new
    
    redirect_to action: "index"
  end
  
  private
 
  #STRONG PARAMS 
  def tweet_params
    params.require(:tweet).permit(:message)
  end
  
  def comment_params
    params[:user_id] = current_user.id
    params.require(:comment).permit(:message,:user_id)
  end
end
