# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardSectionPolicy, type: :policy do
  subject(:board_section_policy) { described_class }

  let(:user) { create(:user, :confirmed) }
  let(:board) { create(:board, user:) }
  let(:board_section) { create(:board_section, board:) }

  permissions :create?, :new? do
    it 'denies access without current_user' do
      expect(board_section_policy).not_to permit(nil, board_section)
    end

    it 'grants access with current_user' do
      expect(board_section_policy).to permit(user, board_section)
    end
  end

  permissions :update?, :edit?, :destroy?, :move?, :move_pin?, :add_pin?, :remove_pin?,
              :select_board_sections?, :autocomplete?, :merge? do
    it 'denies access if not the owner of board' do
      different_user = create(:user, :confirmed)
      expect(board_section_policy).not_to permit(different_user, board_section)
    end

    it 'grants access if the owner of board' do
      expect(board_section_policy).to permit(user, board_section)
    end
  end

  permissions :show? do
    context 'not owner' do
      context 'secret board' do
        it 'denies access' do
          different_user = create(:user, :confirmed)
          secret_board = create(:board, privacy: 'secret')
          secret_board_section = create(:board_section, board: secret_board)
          expect(board_section_policy).not_to permit(different_user, secret_board_section)
        end
      end

      context 'public board' do
        it 'grants access' do
          different_user = create(:user, :confirmed)
          public_board = create(:board, privacy: 'public')
          public_board_section = create(:board_section, board: public_board)
          expect(board_section_policy).to permit(different_user, public_board_section)
        end
      end
    end

    context 'owner' do
      it 'grants access' do
        expect(board_section_policy).to permit(user, board_section)
      end
    end
  end
end
