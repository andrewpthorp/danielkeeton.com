class Post < ActiveRecord::Base
  attr_accessible :body, :published, :title

  validates :title, presence: true
  validates :body, presence: true

  scope :published, where(published: true)
end
