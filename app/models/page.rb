# Public: The Page model handles the blog of the website.
class Page < ActiveRecord::Base

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Pages using FriendlyId.
  friendly_id :title, use: [:slugged, :finders]

  # Internal: Validate presence pf specific attributes.
  validates :title, :body, presence: true

end
