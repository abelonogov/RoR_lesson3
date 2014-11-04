class Post < ActiveRecord::Base

  validates_presence_of :title, :body
  validates_uniqueness_of :title
  validates_length_of :title, minimum: 5, message: 'should be more then 5 characters'
  validates_length_of :title, maximum: 100, message: 'should be less than 100 characters'

end
