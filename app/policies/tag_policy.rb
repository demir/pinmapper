# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def following_tags?
    user.present?
  end

  def follow?
    return if user.blank?

    user.tags.exclude?(record)
  end

  def unfollow?
    return if user.blank?

    user.tags.include?(record)
  end
end
