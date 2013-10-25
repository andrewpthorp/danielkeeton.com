# Public: The DynamicContent class handles all dynamic content that is tied to
# a Region in the website. This includes everything in VALID_SUBJECTS.
class DynamicContent < ActiveRecord::Base

  # Internal: Valid subjects for a DynamicContent.
  VALID_SUBJECTS = %w(biography image)

  # Internal: Each DynamicContent (optionally) belongs to a Region.
  belongs_to :region

  # Internal: Use CarrierWave to mount the DynamicContentUploader on :image.
  mount_uploader :image, DynamicContentUploader

  # Internal: Validate presence of specified attributes.
  validates :title, :content, presence: true

  # Internal: Validate presence and valid state of :subject.
  validates :subject, presence: true,
                      inclusion: { in: DynamicContent::VALID_SUBJECTS }

  # Internal: The default scope should order by :subject, then :id.
  default_scope { order(:subject, :id) }

  # Public: Return all DynamicContent with a given subject for a given region.
  #
  # subject     - The String subject to query for (ex: 'biography').
  # region_slug - The String to find a Region by (ex: 'goochland').
  #
  # Returns an ActiveRecord::Relation.
  def self.content_for(subject, region_slug)
    if region_slug.blank?
      self.where(subject: subject, region_id: nil)
    else
      region = Region.find_by_slug(region_slug)
      contents = self.where(subject: subject, region_id: region.id)
      if contents.empty?
        self.content_for(subject, '')
      else
        contents
      end
    end
  end

end
