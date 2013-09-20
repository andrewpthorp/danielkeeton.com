# Public: The Post model handles the blog of the website.
class Post < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :body, :published, :title

  # Internal: Validate presence pf specific attributes.
  validates :title, :body, presence: true

  # Public: Get all Posts that are published.
  #
  # Returns an ActiveRecord::Relation.
  scope :published, where(published: true)

end
