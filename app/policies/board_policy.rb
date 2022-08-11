# frozen_string_literal: true

class BoardPolicy < ApplicationPolicy
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

  def index?
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

  def move?
    update?
  end

  def show?
    record.user == user ||
      record.public_privacy?
  end

  def add_pin?
    record.user == user
  end

  def remove_pin?
    add_pin?
  end

  def add_to_board_list?
    index?
  end

  def follow?
    return if user.blank?

    user.following_boards.exclude?(record)
  end

  def unfollow?
    return if user.blank?

    user.following_boards.include?(record)
  end

  def following_boards?
    user.present?
  end
end
