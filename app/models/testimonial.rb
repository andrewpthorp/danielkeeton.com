class Testimonial < ActiveRecord::Base
  attr_accessible :body, :name

  validates :body, presence: true
  validates :name, presence: true
end
