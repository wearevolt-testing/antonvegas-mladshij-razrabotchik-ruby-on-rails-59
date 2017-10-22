class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index

    @posts = Post.order('published_at DESC').paginate(page: params[:page], per_page: params[:per_page])

    response.headers["count_of_pages"]  = @posts.total_pages.to_s
    response.headers["count_of_records"]  = @posts.count.to_s

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
