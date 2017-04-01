class Comment < ApplicationRecord
  belongs_to  :user
  belongs_to  :tweet, touch: false 
  before_save :sanitize_comment
  
  def sanitize_comment
    #first sanitize it
    self.message = ActionController::Base.helpers.sanitize(message)
    
    #now add links
    self.message = Rinku.auto_link(self.message, mode=:all, link_attr=nil, skip_tags=nil)
  end
end
