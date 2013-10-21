require 'spec_helper'

describe Region do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:slug) }
    it { should allow_mass_assignment_of(:idx_value) }
    it { should allow_mass_assignment_of(:linkable) }
  end

  describe '.validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:idx_value) }
  end

  describe '.scopes' do
    describe '.linkable' do
      let (:hash) { Region.linkable.where_values_hash }

      it 'should only return linkable Regions' do
        expect(hash).to eq({'linkable' => true})
      end
    end
  end

end
