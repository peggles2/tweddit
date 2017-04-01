class AddLikeDislikeToTweet < ActiveRecord::Migration[5.0]
  def up
    add_column :tweets, :like, :string, array: true, default: []
    add_column :tweets, :dislike, :string, array: true, default: []
  end
  def down
     remove_column :tweets, :like     
     remove_column :tweets, :dislike
  end
end
