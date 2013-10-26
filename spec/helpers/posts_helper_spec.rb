require 'spec_helper'

describe PostsHelper do

  describe '#markdown' do
    it 'should render markdown' do
      expect(helper.markdown('**bold**')).to match('<strong>bold</strong>')
    end

    it 'should set the right options' do
      renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      Redcarpet::Markdown.should_receive(:new)
        .with(Redcarpet::Render::HTML, { autolink: true,
                                         space_after_headers: true })
        .and_return(renderer)
      helper.markdown('')
    end
  end

  describe '#post_status_tag' do
    let (:post) { FactoryGirl.create(:post) }
    let (:results) { helper.post_status_tag(post) }

    context 'with a published post' do
      let (:post) { FactoryGirl.create(:published_post) }

      it 'should return a published tag' do
        expect(results).to have_selector('small.tag.green', text: 'PUBLISHED')
      end
    end

    context 'with a drafted post' do
      it 'should return a draft tag' do
        expect(results).to have_selector('small.tag.light-blue', text: 'DRAFT')
      end
    end
  end

end
