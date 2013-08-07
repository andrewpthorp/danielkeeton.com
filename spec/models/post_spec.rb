require 'spec_helper'

describe Post do

  describe '#validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '#scopes' do
    before do
      @published = FactoryGirl.create(:published_post)
      @post = FactoryGirl.create(:post)
    end

    describe '#published' do
      it 'should only return published posts' do
        Post.published.should eq([@published])
      end
    end
  end

end
