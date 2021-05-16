# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PinPolicy, type: :policy do
  subject(:pin_policy) { described_class }

  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  permissions :create?, :new? do
    it 'denies access without current_user' do
      expect(pin_policy).not_to permit(nil, pin)
    end

    it 'grants access with current_user' do
      expect(pin_policy).to permit(user, pin)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it 'denies access if not the owner of pin' do
      different_user = create(:user, :confirmed)
      expect(pin_policy).not_to permit(different_user, pin)
    end

    it 'grants access if the owner of pin' do
      expect(pin_policy).to permit(user, pin)
    end
  end
end
