class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: 3..20

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: EMAIL_REGEX })

  before_save do
    email.downcase!
    username.downcase!
  end
end
