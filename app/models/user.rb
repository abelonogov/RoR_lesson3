class User < ActiveRecord::Base

  has_secure_password
  has_many :voted_posts, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

end