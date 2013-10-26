require 'spec_helper'

describe Post do

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '.scopes' do
    describe '.default_scope' do
      it 'should order by status, then id' do
        expect(Post.all).to eq(Post.order('created_at DESC'))
      end
    end

    describe '.published' do
      it 'should return published posts' do
        expect(Post.published).to eq(Post.where(published: true))
      end
    end

    describe '.drafted' do
      it 'should return unpublished posts' do
        expect(Post.drafted).to eq(Post.where(published: false))
      end
    end
  end

  describe '.friendly_id' do
    it 'should set a slug' do
      post = FactoryGirl.create(:post)
      post.slug.should_not be_nil
    end
  end

end
