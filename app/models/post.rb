class Post < ActiveRecord::Base

  belongs_to :user
  has_many :voted_posts

  validates :body, presence: true, length: { minimum: 140 }
  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { minimum: 5, maximum: 140 }

  scope :newest, ->  { order( created_at: :desc ) }
  scope :popular, -> { order( voted_rate: :desc ) }
  scope :last_updated, -> { order( updated_at: :desc ) }

end