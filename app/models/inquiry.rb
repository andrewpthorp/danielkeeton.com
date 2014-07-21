class Inquiry < ActiveRecord::Base
  include Humanizer

  # Internal: Valid inquiry types for an Inquiry.
  VALID_TYPES = %w(homeworth contact)

  # Internal: Send email after it was created.
  after_create :send_email

  # Internal: Use humanizer gem to make sure they are humans.
  require_human_on :create

  # Internal: Validate presence and valid type of :inquiry_type.
  validates :inquiry_type, presence: true, inclusion: { in: Inquiry::VALID_TYPES }

  # Internal: Validate presence of specific attributes.
  validates :name, :email, :phone, presence: true

private

  def send_email
    if self.inquiry_type == 'homeworth'
      Mailer.home_worth_email(self.attributes).deliver
    else
      Mailer.contact_email(self.attributes).deliver
    end
  end
end
