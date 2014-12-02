class Comment < ActiveRecord::Base
  after_create :update_post

  belongs_to :post
  belongs_to :user

  scope :can_be_deleted?, -> { where('created_at >= :one_hour_ago', one_hour_ago: Time.now - 1.hour) }

  validates_presence_of :comment

  def update_post
    self.post.touch
  end

  def can_be_deleted?
    one_hour_ago = Time.now - 1.hour
    self.created_at >= one_hour_ago
  end

end
