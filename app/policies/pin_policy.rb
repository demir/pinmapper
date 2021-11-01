# frozen_string_literal: true

class PinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.where(id: own_and_following_pins.ids | tag_pins.ids | board_pins.ids)
             .order(created_at: :desc)
      else
        scope.order(created_at: :desc)
      end
    end

    private

    def tag_pins
      Pin.tagged_with(user.tags, any: true)
    end

    def board_pins
      Pin.joins(boards: :followers)
         .where(followers: { id: user })
         .distinct
    end

    def own_and_following_pins
      Pin.joins(:user)
         .where(users: { id: user.following | Array(user) })
    end
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def like?
    return if user.blank?

    !user.liked?(record)
  end

  def unlike?
    return if user.blank?

    user.liked?(record)
  end

  def liked_pins?
    user.present?
  end
end
