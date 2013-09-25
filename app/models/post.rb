# Public: The Post model handles the blog of the website.
class Post < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :body, :published, :title

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Posts using FriendlyId.
  friendly_id :title, use: :slugged

  # Internal: Validate presence pf specific attributes.
  validates :title, :body, presence: true

  # Public: Get all Posts that are published.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :published, where(published: true)

end
