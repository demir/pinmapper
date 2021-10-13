# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable

  #  relations
  has_many :pins, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id,
                                    class_name:  'Follow',
                                    dependent:   :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id,
                                     class_name:  'Follow',
                                     dependent:   :destroy
  has_many :following, through: :following_relationships, source: :following
end
