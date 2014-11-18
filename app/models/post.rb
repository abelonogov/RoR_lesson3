class Post < ActiveRecord::Base

  belongs_to :user

  validates :body, presence: true
  validates :title, presence: true, uniqueness: {scope: :user_id}, length: {minimum: 5, maximum: 100}

end
