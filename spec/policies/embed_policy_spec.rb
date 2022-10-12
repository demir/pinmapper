# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmbedPolicy, type: :policy do
  subject(:embed_policy) { described_class }

  let(:current_user) { create(:user, :confirmed) }
  let(:user) { create(:user, :confirmed) }

  permissions :update? do
    it 'can not update without current_user' do
      expect(embed_policy).not_to permit(nil, user)
    end

    it 'grants access with current_user' do
      expect(embed_policy).to permit(current_user, user)
    end
  end
end
