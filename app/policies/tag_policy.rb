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
end
