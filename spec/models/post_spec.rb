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

    it 'published_at is required' do
      should validate_presence_of(:published_at)
    end
  end
end
