require 'spec_helper'

describe Post do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:published) }
  end

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '.scopes' do
    describe '.published' do
      let (:hash) { Post.published.where_values_hash }

      it 'should have the right conditions' do
        expect(hash).to eq('published' => true)
      end
    end
  end

end
