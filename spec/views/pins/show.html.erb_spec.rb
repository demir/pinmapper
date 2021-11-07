# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/show', type: :view do
  Pin.destroy_all
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  before do
    assign(:pin, pin)
    render
  end

  context 'renders attributes of pin' do
    it '#name' do
      expect(rendered).to match(/#{pin.name}/)
    end

    it '#user.username' do
      expect(rendered).to match(/#{pin.user.username}/)
    end

    it '#tag_list.first' do
      expect(rendered).to match(/##{pin.tag_list.first}/)
    end

    it '#created_at' do
      expect(rendered).to match(/#{l(pin.created_at)}/)
    end

    it '#description' do
      expect(rendered).to match(/#{pin.description}/)
    end
  end

  describe 'components' do
    context 'with signed in' do
      before do
        sign_in(user)
        render
      end

      it 'like button' do
        expect(rendered).to have_css '.header .hrow .like_btn'
      end

      it 'add to board button' do
        expect(rendered).to have_css '.header .hrow .add_to_board_btn'
      end
    end

    context 'without signed in' do
      it 'like button' do
        expect(rendered).to have_css '.header .hrow .like_btn.disabled'
      end

      it 'add to board button' do
        expect(rendered).not_to have_css '.header .hrow .add_to_board_btn'
      end
    end
  end

  context 'nearby pins' do
    it 'renders nearby pins' do
      create_list(:pin, 3, user: user)
      render
      expect(rendered).to match(/#{t('pins.show.nearby_pins')}/)
    end

    it 'does not render nearby pins' do
      render
      expect(rendered).not_to match(/#{t('pins.show.nearby_pins')}/)
    end
  end

  context 'more button' do
    context 'with sign in' do
      it 'renders edit actions if the owner of pin' do
        sign_in(user)
        render
        assert_select '.header .pin-more .dropdown-menu a', text: t('edit'), count: 1
      end

      it 'does not render edit actions if not the owner of pin' do
        sign_in(create(:user, :confirmed))
        render
        assert_select '.header .pin-more .dropdown-menu a', text: t('edit'), count: 0
      end
    end

    context 'without sign in' do
      it 'does not render' do
        render
        assert_select '.header .pin-more', count: 0
      end
    end
  end
end
