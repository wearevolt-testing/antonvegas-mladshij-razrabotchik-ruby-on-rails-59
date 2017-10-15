class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, :published_at, presence: true
end
