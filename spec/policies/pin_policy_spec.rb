require 'rails_helper'

RSpec.describe PinPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  permissions :create?, :new? do
    it 'denies access without current_user' do
      expect(subject).not_to permit(nil, pin)
    end

    it 'grants access with current_user' do
      expect(subject).to permit(user, pin)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it 'denies access if not the owner of pin' do
      different_user = create(:user, :confirmed)
      expect(subject).not_to permit(different_user, pin)
    end

    it 'grants access if the owner of pin' do
      expect(subject).to permit(user, pin)
    end
  end
end
