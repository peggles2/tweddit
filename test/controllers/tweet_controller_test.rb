require 'test_helper'

class TweetControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @tweet = tweets(:one)
  end
  
  test "get index" do
    get "/" 
    assert_response :success
  end
  
  test "vote up" do
    post "/tweet/vote/up/#{@tweet.id}" 
    assert_response :success
  end
  
  test "vote down" do
    post "/tweet/vote/down/#{@tweet.id}" 
    assert_response :success
  end
  
  test "delete tweet" do
    assert_difference('Tweet.count', -1) do
      delete tweet_url(@tweet)
    end
 
    assert_response :success
  end
  
  test "create tweet" do
      post "/tweet",
        params: { tweet: { message: "can new tweet" } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
  end
  
  test "create comment" do
      post "/tweet/create_comment",
        params: { comment: { message: "create new comment", tweet_id: @tweet.id } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
  end
  
  test "not authenticated should redirect" do 
    #signout user
    sign_out users(:one)
    get "/" 
    assert_response :redirect
  end
end
