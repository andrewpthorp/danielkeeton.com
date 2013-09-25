# Public: The Image class handles storing multiple images for Listings. They
# CarrierWave ListingUploader was removed from the Listing model and added to the
# Image model, with a has_many/belongs_to relationship between Listings and
# Images.
class Image < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :file, :primary

  # Internal: Each Image belongs to a Listing.
  belongs_to :listing

  # Internal: Validates the presence of :file.
  validates :file, presence: true

  # Internal: Use CarrierWave to mount the ListingUploader on :file.
  mount_uploader :file, ListingUploader

  # Internal: Only call :unset_other_primary_images if the Image is :primary.
  before_save :unset_other_primary_images, if: :primary?

  # Internal: Make sure we have atleast one :primary Image for a Listing.
  before_save :ensure_one_primary

  # Public: Get all Images for a given Listing.
  #
  # listing_id - The :id of a Listing to get all Images for.
  #
  # Returns an ActiveRecord::Relation.
  scope :for_listing, lambda { |listing_id| where(listing_id: listing_id) }

  # Public: Get all Images with :primary set to true.
  #
  # Returns an ActiveRecord::Relation.
  scope :primary, where(primary: true)

protected

  # Internal: When :primary is set to true, we want to set :primary to false for
  # every other Image that is bound to the given Listing.
  #
  # Returns nothing.
  def unset_other_primary_images
    Image.for_listing(self.listing_id).primary.update_all(primary: false)
  end

  # Internal: When :primary is set to false, but there are no Images for the
  # given Listing, we should default :primary to true.
  #
  # Returns nothing.
  def ensure_one_primary
    self.primary = true if Image.for_listing(self.listing_id).primary.none?
  end

end
