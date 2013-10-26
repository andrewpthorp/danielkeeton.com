# Public: The Post model handles the blog of the website.
class Post < ActiveRecord::Base

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Posts using FriendlyId.
  friendly_id :title, use: [:slugged, :finders]

  # Internal: Validate presence pf specific attributes.
  validates :title, :body, presence: true

  # Internal: The default scope should order by created_at DESC.
  default_scope { order('created_at DESC') }

  # Public: Get all Posts that are published.
  #
  # Returns a Post::FriendlyIdActiveRecordRelation.
  scope :published, -> { where(published: true) }

end
