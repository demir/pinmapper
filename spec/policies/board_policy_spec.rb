# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardPolicy, type: :policy do
  subject(:board_policy) { described_class }

  let(:user) { create(:user, :confirmed) }
  let(:board) { create(:board, user:) }

  permissions :create?, :new?, :index?, :add_to_board_list?, :add_to_board_section_list?, :following_boards? do
    it 'denies access without current_user' do
      expect(board_policy).not_to permit(nil, board)
    end

    it 'grants access with current_user' do
      expect(board_policy).to permit(user, board)
    end
  end

  permissions :update?, :edit?, :destroy?, :move?, :add_pin?, :remove_pin?,
              :move_board_by_id?, :move_board_section? do
    it 'denies access if not the owner of board' do
      different_user = create(:user, :confirmed)
      expect(board_policy).not_to permit(different_user, board)
    end

    it 'grants access if the owner of board' do
      expect(board_policy).to permit(user, board)
    end
  end

  permissions :show? do
    context 'not owner' do
      context 'secret board' do
        it 'denies access' do
          different_user = create(:user, :confirmed)
          secret_board = create(:board, privacy: 'secret')
          expect(board_policy).not_to permit(different_user, secret_board)
        end
      end

      context 'public board' do
        it 'grants access' do
          different_user = create(:user, :confirmed)
          expect(board_policy).to permit(different_user, board)
        end
      end
    end

    context 'owner' do
      it 'grants access' do
        expect(board_policy).to permit(user, board)
      end
    end
  end

  permissions :follow? do
    it 'can not follow without current_user' do
      expect(board_policy).not_to permit(nil, board)
    end

    it 'denies access if already followed by current_user' do
      user.following_boards << board
      expect(board_policy).not_to permit(user, board)
    end

    it 'grants access if not followed by current_user' do
      expect(board_policy).to permit(user, board)
    end
  end

  permissions :unfollow? do
    it 'can not unfollow without current_user' do
      expect(board_policy).not_to permit(nil, board)
    end

    it 'denies access if not followed by current_user' do
      expect(board_policy).not_to permit(user, board)
    end

    it 'grants access if liked by current_user' do
      user.following_boards << board
      expect(board_policy).to permit(user, board)
    end
  end
end
