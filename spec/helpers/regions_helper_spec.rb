require 'spec_helper'

describe RegionsHelper do

  describe '#regions_nav' do
    let (:results) { helper.regions_nav }
    let! (:goochland) { FactoryGirl.create(:region, name: 'Goochland',
                                           slug: 'goochland', idx_value: 18400,
                                           linkable: true) }
    let! (:richmond) {  FactoryGirl.create(:region, name: 'Richmond',
                                           slug: 'richmond', idx_value: 39267,
                                           linkable: true) }


    before do
      helper.stub!(:url_for).and_return('/')
    end

    it 'should return a definition list' do
      expect(results).to have_selector('dl.sub-nav.regions')
    end

    it 'should have the correct number of links' do
      expect(results).to have_selector('a', count: Region.linkable.count + 1)
    end

    context 'when no region is stored in the session' do
      it 'should make the active link All Regions' do
        expect(results).to have_selector('dd.active', text: 'All Regions')
      end
    end

    context 'when a region is stored in the session' do
      context 'and that region is goochland' do
        it 'should make the active link Goochland' do
          session[:region] = goochland.slug
          expect(results).to have_selector('dd.active', text: goochland.name)
        end
      end

      context 'and that region is richmond' do
        it 'should make the active link Richmond' do
          session[:region] = richmond.slug
          expect(results).to have_selector('dd.active', text: richmond.name)
        end
      end
    end
  end

end
