# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :followships, foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :followships, source: :follower

  validates :title, presence: true
  validates :content, presence: true
end
