# Public: The Listing class handles the storage of real estate listings in the
# website.
class Listing < ActiveRecord::Base

  # Internal: Valid states for a Listing.
  VALID_STATES = %w(for_sale for_rent under_contract sold cancelled)

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :title of Listings using FriendlyId.
  friendly_id :title, use: [:slugged, :finders]

  # Internal: Each Listing has many Images.
  has_many :images, dependent: :destroy

  # Internal: Allow us to create Images from the Listing forms.
  accepts_nested_attributes_for :images, allow_destroy: true

  # Internal: Validate that at least one Image is stored with a Listing.
  validates :images, length: { minimum: 1 }

  # Internal: Use Geocoder to store latitude and longitude.
  geocoded_by :full_address

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
  validates :year_built, numericality: { greater_than_or_equal_to: 1800 },
                          allow_nil: true

  # Internal: Validate numericality of :square_footage, allow it to be nil.
  validates :square_footage, numericality: { greater_than_or_equal_to: 500 },
                              allow_nil: true

  # Internal: Validate numericality of :lot_size, allow it to be nil.
  validates :lot_size, numericality: { greater_than_or_equal_to: 1000 },
                        allow_nil: true

  # Internal: Ensure that only one Listing is featured.
  before_save :ensure_single_featured

  # Internal: After validating the Listing, geocode for latitude and longitude.
  after_validation :geocode

  # Public: Get all Listings where featured is set to true.
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :featured, -> { where(featured: true) }

  # Public: Get all Listings where status is set to 'for_sale.'
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :for_sale, -> { where(status: 'for_sale') }

  # Public: Get all Listings where status is set to 'for_rent.'
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :for_rent, -> { where(status: 'for_rent') }

  # Public: Get all Listings where status is set to 'under_contract.'
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :under_contract, -> { where(status: 'under_contract') }

  # Public: Get all Listings where status is set to 'sold.'
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :sold, -> { where(status: 'sold') }

  # Public: Get all Listings where status is set to 'cancelled.'
  #
  # Returns a Listing::FriendlyIdActiveRecordRelation.
  scope :cancelled, -> { where(status: 'cancelled') }

  # Public: Get a formatted version of my address.
  #
  # Returns a String.
  def full_address
    "#{address_line_1}, #{city}, #{state}, #{zip}"
  end

  # Public: Get the Image for the Listing with :primary set to true.
  #
  # Returns an Image.
  def primary_image
    self.images.primary.first
  end

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
