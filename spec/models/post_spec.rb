require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'relationships' do
    it 'has many comments' do
      should have_many(:comments).dependent(:destroy)
    end

    it 'belongs to user' do
      should belong_to(:user)
    end
  end

  describe 'validate of post' do
    it 'title is required' do
      should validate_presence_of(:title)
    end

    it 'body is required' do
      should validate_presence_of(:body)
    end
  end

  describe 'autocomplite' do
    it 'complite published_at' do
      post = FactoryGirl.create :post
      expect(post.published_at).not_to be_nil
    end
  end
end
