# frozen_string_literal: true

class BoardSectionPolicy < ApplicationPolicy
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
    record.board.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def move?
    update?
  end

  def move_pin?
    update?
  end

  def show?
    record.board.user == user ||
      record.board.public_privacy?
  end

  def add_pin?
    update?
  end

  def remove_pin?
    update?
  end

  def select_board_sections?
    update?
  end

  def autocomplete?
    update?
  end

  def merge?
    update?
  end
end
