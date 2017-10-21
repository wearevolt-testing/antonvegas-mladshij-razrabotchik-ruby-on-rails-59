require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  describe 'call' do
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.call

        expect(result[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a missing token error' do
          expect { invalid_request_obj.call }.to raise_error('missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises an invalid token error' do
          expect { invalid_request_obj.call }.to raise_error('invalid token')
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises Exception invalid token' do
          expect { request_obj.call }.to raise_error('invalid token')
        end
      end
    end
  end
end
