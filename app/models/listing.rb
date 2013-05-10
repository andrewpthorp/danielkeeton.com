class Listing < ActiveRecord::Base
  attr_accessible :title, :description, :status, :price, :featured
  VALID_STATES = %w(for_sale for_rent under_contract sold cancelled)

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: Listing::VALID_STATES }
  validates :price, presence: true

  before_save :ensure_single_featured

  scope :featured, where(featured: true)

  mount_uploader :image, ListingUploader

private

  def ensure_single_featured
    Listing.all.delete_if { |l| l == self }.each do |listing|
      listing.update_column(:featured, false)
    end if self.featured
  end
end
