# frozen_string_literal: true

class EmbedPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.present?
  end
end
