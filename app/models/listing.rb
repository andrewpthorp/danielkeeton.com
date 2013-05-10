class Listing < ActiveRecord::Base
  attr_accessible :title, :description, :status, :price, :featured, :link
  VALID_STATES = %w(for_sale for_rent under_contract sold cancelled)

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: Listing::VALID_STATES }
  validates :price, presence: true

  before_save :ensure_single_featured

  scope :featured, where(featured: true)
  scope :for_sale, where(status: 'for_sale')
  scope :for_rent, where(status: 'for_rent')
  scope :under_contract, where(status: 'under_contract')
  scope :sold, where(status: 'sold')

  mount_uploader :image, ListingUploader

private

  def ensure_single_featured
    Listing.all.delete_if { |l| l == self }.each do |listing|
      listing.update_column(:featured, false)
    end if self.featured
  end
end
