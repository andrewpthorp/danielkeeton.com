require 'spec_helper'

describe Region do

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
