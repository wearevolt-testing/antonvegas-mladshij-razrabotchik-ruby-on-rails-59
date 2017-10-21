class Post < ApplicationRecord
  before_validation :add_published_at

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :body, :published_at, presence: true

  private

  def add_published_at
    self.published_at = Time.now.strftime('%Y-%m-%d %H:%M:%S') if published_at.nil?
  end
end
