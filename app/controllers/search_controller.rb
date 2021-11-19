# frozen_string_literal: true

class SearchController < ApplicationController
  include Pagy::Backend

  def pins
    pins = Pin.pg_search(params[:q]).order(created_at: :desc)
    @pagy, @pins = pagy pins
  end

  def boards
    boards = Board.search_boards(params[:q])
    boards = if current_user.present?
               boards.where('user_id != ? AND privacy = 0 OR user_id = ?',
                            current_user.id,
                            current_user.id)
             else
               boards.public_privacy
             end.order(created_at: :desc)
    @pagy, @boards = pagy boards
  end

  def users
    users = User.pg_search(params[:q]).order(created_at: :desc)
    @pagy, @users = pagy users
  end
end
