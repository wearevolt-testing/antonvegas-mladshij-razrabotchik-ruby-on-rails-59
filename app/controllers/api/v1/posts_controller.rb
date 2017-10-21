class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all

    render json: @posts
  end

  def create
    @post = current_user.posts.create!(post_params)

    render json: @post
  end

  def show
    render json: @post
  end

  private

  def post_params
    params.permit(:title, :body, :published_at)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
