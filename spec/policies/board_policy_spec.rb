# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardPolicy, type: :policy do
  subject(:board_policy) { described_class }

  let(:user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: user) }

  permissions :create?, :new?, :index? do
    it 'denies access without current_user' do
      expect(board_policy).not_to permit(nil, board)
    end

    it 'grants access with current_user' do
      expect(board_policy).to permit(user, board)
    end
  end

  permissions :update?, :edit?, :destroy?, :show? do
    it 'denies access if not the owner of board' do
      different_user = create(:user, :confirmed)
      expect(board_policy).not_to permit(different_user, board)
    end

    it 'grants access if the owner of board' do
      expect(board_policy).to permit(user, board)
    end
  end
end
