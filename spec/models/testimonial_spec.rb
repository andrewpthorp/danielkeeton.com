require 'spec_helper'

describe Testimonial do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:name) }
end
