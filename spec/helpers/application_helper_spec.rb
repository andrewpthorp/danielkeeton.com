require 'spec_helper'

describe ApplicationHelper do

  describe '#regions_nav' do
    let (:results) { helper.regions_nav }

    before do
      helper.stub!(:url_for).and_return('/')
    end

    it 'should return a definition list' do
      expect(results).to have_selector('dl.sub-nav.regions')
    end

    it 'should have 3 links' do
      expect(results).to have_selector('a', count: 3)
    end

    context 'when no region is stored in the session' do
      it 'should make the active link All Regions' do
        expect(results).to have_selector('dd.active', text: 'All Regions')
      end
    end

    context 'when a region is stored in the session' do
      context 'and that region is goochland' do
        it 'should make the active link Goochland' do
          session[:region] = 'goochland'
          expect(results).to have_selector('dd.active', text: 'Goochland')
        end
      end

      context 'and that region is richmond' do
        it 'should make the active link Richmond' do
          session[:region] = 'richmond'
          expect(results).to have_selector('dd.active', text: 'Richmond')
        end
      end
    end
  end

end
