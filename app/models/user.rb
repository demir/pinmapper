# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveRecord::Searchable

  acts_as_voter
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable

  #  callbacks
  after_create :create_profile_record
  after_update :update_pins_cached_user_username, if: :saved_change_to_username?

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
  has_one :profile, dependent: :destroy

  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 30 },
                       if: proc { |u| u.username.blank? || u.username_changed? }
  validates :username, format: { with: /\A[a-z0-9_]*\z/, multiline: true }, if: :username_changed?
  validate :validate_username, if: :username_changed?
  validates :pins_count, presence: true
  validates :boards_count, presence: true
  validates :public_boards_count, presence: true
  validates :secret_boards_count, presence: true
  validates :following_count, presence: true
  validates :followers_count, presence: true
  validates :tags_count, presence: true
  validates :following_boards_count, presence: true

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

  def create_profile_record
    create_profile(bio: nil)
  end

  def update_pins_cached_user_username
    # rubocop:disable Rails/SkipsModelValidations
    pins.update_all(cached_user_username: username)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
