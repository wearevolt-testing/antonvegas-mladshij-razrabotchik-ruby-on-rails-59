require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'relationships' do
    it 'belongs to user' do
      should belong_to(:user)
    end

    it 'belongs to post' do
      should belong_to(:post)
    end
  end

  describe 'validate of comment' do
    it 'body is required' do
      should validate_presence_of(:body)
    end

    it 'published_at is required' do
      should validate_presence_of(:published_at)
    end
  end
end
