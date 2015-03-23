class Mailer < ActionMailer::Base
  default from: "danielspencerkeeton+website@gmail.com"

  def home_worth_email(hash)
    @data = hash
    mail(to: "danielspencerkeeton@gmail.com", subject: "Website - What's My Home Worth")
  end

  def selling_email(hash)
    @data = hash
    mail(to: "danielspencerkeeton@gmail.com", subject: "Website - Selling")
  end

  def contact_email(hash)
    @data = hash
    mail(to: "danielspencerkeeton@gmail.com", subject: "Website - Contact Form")
  end
end
