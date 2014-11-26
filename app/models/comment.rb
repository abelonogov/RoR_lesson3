class Comment < ActiveRecord::Base
  after_create :update_post
  belongs_to :post
  
  def update_post
    self.post.touch
  end
end
