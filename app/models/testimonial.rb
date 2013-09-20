# Public: The Testimonial model handles feedback from customers on the website.
class Testimonial < ActiveRecord::Base

  # Internal: Allow mass-assignment
  attr_accessible :body, :name

  # Internal: Validate presence of specific attributes.
  validates :body, :name, presence: true

end
