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

end
