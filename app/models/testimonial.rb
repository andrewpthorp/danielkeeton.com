# Public: The Testimonial model handles feedback from customers on the website.
class Testimonial < ActiveRecord::Base

  # Internal: Validate presence of specific attributes.
  validates :body, :name, presence: true

end
