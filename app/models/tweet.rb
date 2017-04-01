class Tweet < ApplicationRecord
  belongs_to  :user
  has_many    :comments
  before_save :sanitize_comment
  
  def sanitize_comment
    #first sanitize it
    self.message = ActionController::Base.helpers.sanitize(message)
    
    #now add links
    self.message = Rinku.auto_link(self.message, mode=:all, link_attr=nil, skip_tags=nil)
  end
end
