require 'spec_helper'

describe Testimonial do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:name) }
  end

  describe '.validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:name) }
  end

end
