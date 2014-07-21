require 'spec_helper'

describe Inquiry do
  before do
    Mailer.stub_chain(:home_worth_email, :deliver)
    Mailer.stub_chain(:contact_email, :deliver)
  end

  describe '.validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should ensure_inclusion_of(:inquiry_type).in_array(Inquiry::VALID_TYPES) }

    it 'should require human with a correct answer' do
      inquiry = FactoryGirl.build(:inquiry, humanizer_answer: 'Foo')
      expect(inquiry).not_to be_valid
    end
  end

  describe '.callbacks' do
    describe '.send_email' do
      [ { itype: 'homeworth', method: :home_worth_email },
        { itype: 'contact', method: :contact_email } ].each do |p|
        context "when the inquiry has an inquiry_type of #{p[:itype]}" do
          it "should send a #{p[:method]}" do
            inquiry = FactoryGirl.build(:inquiry, inquiry_type: p[:itype])
            expect(Mailer).to receive(p[:method])
            inquiry.save
          end
        end
      end
    end
  end

end
