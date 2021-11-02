# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_voter
  attr_writer :login

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
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :user_boards, dependent: :destroy
  has_many :following_boards, through: :user_boards, source: :board, dependent: :destroy

  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :username, format: { with: /^[a-z0-9_.]*$/, multiline: true }
  validate :validate_username

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  private

  def validate_username
    errors.add(:username, :invalid) if User.exists?(email: username)
  end
end
