# Public: Regions handle our sessions, idx regions, etc.
class Region < ActiveRecord::Base

  # Internal: Validate presence of specific attributes.
  validates :name, :slug, :idx_value, presence: true

  # Public: Get all Regions with :linkable set to true.
  scope :linkable, -> { where(linkable: true) }

end
