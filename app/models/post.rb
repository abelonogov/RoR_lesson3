class Post < ActiveRecord::Base

  validates :body, presence: true
  validates :title, presence: true, uniqueness: true, length: {minimum: 5, maximum: 100}
  belongs_to :user

end
