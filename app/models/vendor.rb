# Public: The Vendor class handles all vendors in the website.
# This includes everything in VALID_SUBJECTS.
class Vendor < ActiveRecord::Base

  # Internal: Use CarrierWave to mount the VendorUploader on :image.
  mount_uploader :image, VendorUploader

  # Internal: Validate presence of specified attributes.
  validates :label, presence: true

end
