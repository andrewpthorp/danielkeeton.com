class Inquiry < ActiveRecord::Base
  include Humanizer

  # Internal: Send email after it was created.
  after_create :send_email

  # Internal: Use humanizer gem to make sure they are humans.
  require_human_on :create

private

  def send_email
    if self.inquiry_type == 'homeworth'
      Mailer.home_worth_email(self.attributes).deliver
    else
      Mailer.contact_email(self.attributes).deliver
    end
  end
end
