require 'rails_helper'

RSpec.describe 'Post api', type: :request do
  let!(:user) { FactoryGirl.create :user }
  let!(:posts) { create_list(:post, 15, user: user) }
  let(:id) { posts.first.id }
  let(:headers) { valid_headers }
  let(:valid_params) { '{ "title" : "Some title", "body" : "Text for post" }' }

  describe 'POST /api/v1/posts.json' do
    context 'request is valid' do
      before { post '/api/v1/posts.json', params: valid_params, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end

      it 'creates a post' do
        expect(json.keys).to include('id', 'title', 'body', 'published_at', 'author_nickname')
        expect(json.size).to eq(5)
      end

      it 'current user has new post' do
        expect(json['author_nickname']).to eq(user.nickname)
      end
    end

    context 'request is not valid' do
      it 'returns an array of errors' do
        post '/api/v1/posts.json', params: {}, headers: headers

        expect(json.keys).to include('errors')
      end
    end
  end

  describe 'GET /api/v1/post/:post_id.json' do
    it 'returns a post' do
      get "/api/v1/posts/#{id}", headers: headers

      expect(json.keys).to include('id', 'title', 'body', 'published_at', 'author_nickname')
      expect(json.size).to eq(5)
    end

    it 'responds with 404' do
      get '/api/v1/posts/0', headers: headers
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /api/v1/posts.json' do
    context 'request is valid' do
      let(:per_page) { 7 }
      before { get '/api/v1/posts.json', params: { page: 1, per_page: per_page },  headers: headers }

      it 'returns posts' do
        expect(json).not_to be_empty
        expect(json.size).to eq(7)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'right sort by published_at' do
        sorted_posts = posts.sort_by {|v| v[:published_at] }.reverse.first(per_page)

        expect(json[0]['id']).to eq(sorted_posts[0][:id])
        expect(json[per_page-1]['id']).to eq(sorted_posts[per_page-1][:id])
      end
    end
  end
end
