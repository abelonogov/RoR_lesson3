class User < ActiveRecord::Base

  has_secure_password
  has_many :voted_posts
  has_many :posts

end