# frozen_string_literal: true

class PinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
