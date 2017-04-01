class TweetController < ApplicationController
  before_action :authenticate_user!
  #attr_accessor :message, comment: [:message, :twitter_id]
  def index
    @tweet   = Tweet.new
    @comment = Comment.new
    @tweets  = Tweet.all.order('created_at DESC')
    @friends = current_user.get_friends
  end
 
  def destroy
    @tweet = Tweet.find(params[:id]).destroy
  end
  
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
  
  def create_comment
    comment  = params[:comment]
    tweet_id = comment[:tweet_id]
    @tweet   = Tweet.find(tweet_id)
    @comment = @tweet.comments.create({message: comment[:message], user_id: current_user.id})
    @comment = Comment.new
    
    redirect_to action: "index"
  end
  
  def create
    tweet    = params[:tweet]
    message  = tweet[:message]
    @tweet   = current_user.tweets.create({message: message})
    @comment = Comment.new
    
    redirect_to action: "index"
  end
  
end
