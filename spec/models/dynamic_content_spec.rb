require 'spec_helper'

describe DynamicContent do

  describe '.associations' do
    it { should belong_to(:region) }
  end

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:subject) }
    it { should allow_value('biography').for(:subject) }
    it { should_not allow_value('cannon').for(:subject) }
  end

  describe '.scopes' do
    describe '.default_scope' do
      it 'should order by subject, then id' do
        expect(DynamicContent.all).to eq(DynamicContent.order(:subject, :id))
      end
    end
  end

  describe '.methods' do
    describe '.content_for' do
      let! (:with_region) { FactoryGirl.create(:dynamic_content_with_region) }
      let! (:no_region) { FactoryGirl.create(:dynamic_content) }
      let (:region) { '' }
      let (:content) { DynamicContent.content_for('biography', region) }

      context 'when the region_slug is blank' do
        it 'should return all contents for the given subject with no region' do
          expect(content).to eq([no_region])
        end
      end

      context 'when the region_slug is not blank' do
        let (:region) { with_region.region.slug }

        it 'should return all contents for the given subject and region' do
          expect(content).to eq([with_region])
        end

        context 'when there is no content for the region_slug' do
          let (:region) { FactoryGirl.create(:region, slug: 'sussex').slug  }

          it 'should return all contents for the given subject and no region' do
            expect(content).to eq([no_region])
          end
        end
      end
    end
  end

end
