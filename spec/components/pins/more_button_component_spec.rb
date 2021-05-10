require 'rails_helper'

RSpec.describe Pins::MoreButtonComponent, type: :component do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'with current_user' do
    it 'renders more button' do
      render_inline(described_class.new(pin: pin, current_user: user))
      expect(rendered_component).to have_css '.pin-more .bi-three-dots'
    end

    it 'renders edit actions if the owner of pin' do
      render_inline(described_class.new(pin: pin, current_user: user))
      expect(rendered_component).to have_css '.pin-more .dropdown-menu a', text: I18n.t('edit')
      expect(rendered_component).to have_css '.pin-more .dropdown-menu a', text: I18n.t('destroy')
    end

    it 'is not renders edit actions if not the owner of pin' do
      different_user = create(:user, :confirmed)
      render_inline(described_class.new(pin: pin, current_user: different_user))
      expect(rendered_component).not_to have_css '.pin-more .dropdown-menu a', text: I18n.t('edit')
      expect(rendered_component).not_to have_css '.pin-more .dropdown-menu a', text: I18n.t('destroy')
    end
  end

  context 'without current_user' do
    it 'is not renders more button' do
      render_inline(described_class.new(pin: pin))
      expect(rendered_component).not_to have_css '.pin-more'
    end
  end
end
