# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def follow?
    return if user.blank?

    user.following.exclude?(record)
  end

  def unfollow?
    return if user.blank?

    user.following.include?(record)
  end
end
