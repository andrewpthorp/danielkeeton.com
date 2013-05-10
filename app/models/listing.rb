class Listing < ActiveRecord::Base
  attr_accessible :title, :description, :status, :price, :featured

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :price, presence: true

  before_save :ensure_single_featured

  scope :featured, where(featured: true)

private

  def ensure_single_featured
    Listing.all.delete_if { |l| l == self }.each do |listing|
      listing.update_column(:featured, false)
    end if self.featured
  end
end
