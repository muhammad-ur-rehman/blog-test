# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followships, foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :followships, source: :followed

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def follow(post)
    following << post
  end

  def unfollow(post)
    following.delete(post)
  end

  def following?(post)
    following.include?(post)
  end
end
