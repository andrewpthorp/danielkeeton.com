# Public: The Listing class handles the storage of real estate listings in the
# website.
class Listing < ActiveRecord::Base

  # Internal: Valid states for a Listing.
  VALID_STATES = %w(for_sale for_rent under_contract sold cancelled)

  # Internal: Allow mass-assignment.
  attr_accessible :title, :description, :status, :price, :featured, :link,
                  :address_line_1, :address_line_2, :city, :state, :zip,
                  :bedrooms, :bathrooms, :year_built, :square_footage,
                  :lot_size, :image

  # Internal: Use CarrierWave to handle Images for the Listings.
  mount_uploader :image, ListingUploader

  # Internal: Validate presence of specific attributes.
  validates :title, :description, :price, presence: true

  # Internal: Validate presence and valid state of :status.
  validates :status, presence: true, inclusion: { in: Listing::VALID_STATES }

  # Internal: Validate presence and correct numericality of :bathrooms.
  validates :bathrooms, presence: true,
                        numericality: { greater_than_or_equal_to: 0.5 }

  # Internal: Validate presence and correct numericality of :bedrooms.
  validates :bedrooms, presence: true,
                        numericality: { only_integer: true, greater_than: 0 }

  # Internal: Validate numericality of :year_built, allow it to be nil.
  validates :year_built, numericality: { greater_than_or_equal_to: 1900 },
                          allow_nil: true

  # Internal: Validate numericality of :square_footage, allow it to be nil.
  validates :square_footage, numericality: { greater_than_or_equal_to: 500 },
                              allow_nil: true

  # Internal: Validate numericality of :lot_size, allow it to be nil.
  validates :lot_size, numericality: { greater_than_or_equal_to: 1000 },
                        allow_nil: true

  # Internal: Ensure that only one Listing is featured.
  before_save :ensure_single_featured

  # Public: Get all Listings where featured is set to true.
  #
  # Returns an ActiveRecord::Relation.
  scope :featured, where(featured: true)

  # Public: Get all Listings where status is set to 'for_sale.'
  #
  # Returns an ActiveRecord::Relation.
  scope :for_sale, where(status: 'for_sale')

  # Public: Get all Listings where status is set to 'for_rent.'
  #
  # Returns an ActiveRecord::Relation.
  scope :for_rent, where(status: 'for_rent')

  # Public: Get all Listings where status is set to 'under_contract.'
  #
  # Returns an ActiveRecord::Relation.
  scope :under_contract, where(status: 'under_contract')

  # Public: Get all Listings where status is set to 'sold.'
  #
  # Returns an ActiveRecord::Relation.
  scope :sold, where(status: 'sold')

  # Public: Get all Listings where status is set to 'cancelled.'
  #
  # Returns an ActiveRecord::Relation.
  scope :cancelled, where(status: 'cancelled')

private

  # Internal: Ensure that only one Listing is featured. If the current Listing
  # is not featured, this is basically a noop. If the current Listing is
  # featured, we update all other Listings to not be featured.
  #
  # Returns nothing.
  def ensure_single_featured
    Listing.all.delete_if { |l| l == self }.each do |listing|
      listing.update_column(:featured, false)
    end if self.featured
  end
end
