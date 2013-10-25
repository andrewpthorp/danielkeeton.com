require 'spec_helper'

describe DynamicContentsHelper do

  describe '#slider_caption' do
    let (:content) { FactoryGirl.create(:dynamic_content) }
    let (:results) { helper.slider_caption(content) }

    it 'should return a div with the class orbit-caption' do
      expect(results).to have_selector('div.orbit-caption')
    end

    it 'should include the content for medium and up screens' do
      expect(results).to have_selector('div.hide-for-small.show-for-medium-up',
                                       text: content.content)
    end

    context 'when mobile_content is blank' do
      it 'should truncate the content for small screens' do
        content.mobile_content = ''
        content.content = 'This is a content with more than 40 chars.'
        expect(results).to(
          have_selector('div.show-for-small.hide-for-medium-up',
                        text: helper.truncate(content.content, length: 40))
        )
      end
    end

    context 'when mobile_content is not blank' do
      it 'should include the mobile_content for small screens' do
        content.mobile_content = 'This is a mobile caption.'
        expect(results).to(
          have_selector('div.show-for-small.hide-for-medium-up',
                        text: content.mobile_content)
        )
      end
    end
  end

end
