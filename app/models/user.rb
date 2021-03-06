# frozen_string_literal: true

class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, through: :articles

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save { self.email = email.downcase }
end
