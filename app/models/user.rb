class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nickname, :email, presence: true
  validates :email, uniqueness: true, on: :create

  validates :password, confirmation: true,
                       unless: proc { |a| a.password.blank? }
end
