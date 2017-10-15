require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it 'has many comments' do
      should have_many(:comments).dependent(:destroy)
    end

    it 'has many posts' do
      should have_many(:posts).dependent(:destroy)
    end
  end

  describe 'validate of user' do
    it 'nickname is required' do
      should validate_presence_of(:nickname)
    end

    it 'email is required' do
      should validate_presence_of(:email)
    end

    it 'email is unique' do
      should validate_uniqueness_of(:email).on(:create)
    end
  end
end
