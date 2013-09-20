require "spec_helper"

describe Mailer do

  describe '.home_worth_email' do
    before do
      @mail = Mailer.home_worth_email({name: 'Andrew'})
    end

    it 'should render the subject' do
      expect(@mail.subject).to eq("Website - What's My Home Worth")
    end

    it 'should send the email to the right person' do
      expect(@mail.to).to eq(['danielspencerkeeton@gmail.com'])
    end

    it 'should set the sender to the right email' do
      expect(@mail.from).to eq(['danielspencerkeeton+website@gmail.com'])
    end

    it 'should assign @data' do
      expect(@mail.body.encoded).to match('Andrew')
    end
  end

  describe '.contact_email' do
    before do
      @mail = Mailer.contact_email({name: 'Daniel'})
    end

    it 'should render the subject' do
      expect(@mail.subject).to eq('Website - Contact Form')
    end

    it 'should send the email to the right person' do
      expect(@mail.to).to eq(['danielspencerkeeton@gmail.com'])
    end

    it 'should set the sender to the right email' do
      expect(@mail.from).to eq(['danielspencerkeeton+website@gmail.com'])
    end

    it 'should assign @data' do
      expect(@mail.body.encoded).to match('Daniel')
    end
  end

end
