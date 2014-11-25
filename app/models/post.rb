class Post < ActiveRecord::Base

  belongs_to :user
  has_many :voted_posts

  default_scope  { order( created_at: :desc ) }

  validates :body, presence: true, length: { minimum: 140 }
  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 5, maximum: 140 }

end