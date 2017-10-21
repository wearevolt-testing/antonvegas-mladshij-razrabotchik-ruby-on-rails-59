require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # before { allow(request).to receive(:headers).and_return(headers) }

    context 'When request is valid' do
      it 'returns an authentication token' do
        post '/auth/login', params: valid_credentials, headers: headers

        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      it 'returns a failure message' do
        post '/auth/login', params: invalid_credentials, headers: headers

        expect(json['message']).to match('invalid credentials')
      end
    end
  end
end
