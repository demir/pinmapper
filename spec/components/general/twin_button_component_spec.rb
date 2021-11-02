# frozen_string_literal: true

require 'rails_helper'

RSpec.describe General::TwinButtonComponent, type: :component do
  let(:current_user) { create(:user, :confirmed) }
  let(:user) { create(:user, :confirmed) }

  context 'first button' do
    context 'when there is no relation' do
      it 'shows first button' do
        render_inline(described_class.new(
                        first_button:       current_user.following.exclude?(user),
                        record_dom_id:      "user_#{user.id}",
                        first_button_path:  follow_profile_path(id: user),
                        second_button_path: unfollow_profile_path(id: user)
                      ))
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('follow'), exact_text: true
      end
    end

    context 'when there is relation' do
      before do
        FollowServices::FollowUser.call(current_user, user)
        render_inline(described_class.new(
                        first_button:       current_user.following.exclude?(user),
                        record_dom_id:      "user_#{user.id}",
                        first_button_path:  follow_profile_path(id: user),
                        second_button_path: unfollow_profile_path(id: user)
                      ))
      end

      it 'do not show button' do
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('following'), exact_text: true
      end
    end
  end

  context 'display' do
    context 'when true' do
      it 'shows button' do
        render_inline(described_class.new(display: true))
        expect(rendered_component).to have_css '.btn_1'
      end
    end

    context 'when false' do
      it 'do not show button' do
        render_inline(described_class.new(display: false))
        expect(rendered_component).not_to have_css '.btn_1'
      end
    end
  end

  context 'record_dom_id' do
    it 'sets dom_id' do
      render_inline(described_class.new(record_dom_id: "user_#{user.id}"))
      expect(rendered_component).to have_css "div[id='twin_button_user_#{user.id}']"
    end

    describe 'default' do
      it 'sets to empty' do
        render_inline(described_class.new)
        expect(rendered_component).to have_css "div[id='twin_button_']"
      end
    end
  end

  context 'method' do
    it 'sets method' do
      render_inline(described_class.new(method: :post))
      expect(rendered_component).to have_css 'a.btn_1[data-method="post"]'
    end

    describe 'default' do
      it 'sets method to get' do
        render_inline(described_class.new)
        expect(rendered_component).to have_css 'a.btn_1[data-method="get"]'
      end
    end
  end

  context 'first_button_text' do
    it 'sets first button text' do
      render_inline(described_class.new(first_button_text: 'Action Pinmapper!'))
      expect(rendered_component).to have_css '.btn_1', text: 'Action Pinmapper!', exact_text: true
    end

    describe 'default' do
      it "sets text to #{I18n.t('follow')}" do
        render_inline(described_class.new)
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('follow'), exact_text: true
      end
    end
  end

  context 'first_button_class' do
    it 'sets first button class' do
      render_inline(described_class.new(first_button_class: 'btn_1 foo boo'))
      expect(rendered_component).to have_css '.btn_1.foo.boo'
    end

    describe 'default' do
      it 'sets class to "btn_1 rounded small outline"' do
        render_inline(described_class.new)
        expect(rendered_component).to have_css '.btn_1.rounded.small.outline'
      end
    end
  end

  context 'first_button_path' do
    it 'sets first button path' do
      render_inline(described_class.new(first_button_path: follow_profile_path(id: user)))
      expect(rendered_component).to have_css "a.btn_1[href='#{follow_profile_path(id: user)}']"
    end

    describe 'default' do
      it 'sets path to "#"' do
        render_inline(described_class.new)
        expect(rendered_component).to have_css 'a.btn_1[href="#"]'
      end
    end
  end

  context 'second_button_mouseout_text' do
    it 'sets second button mouseout text' do
      render_inline(described_class.new(first_button: false, second_button_mouseout_text: 'Action Pinmapper!'))
      expect(rendered_component).to have_css '.btn_1', text: 'Action Pinmapper!', exact_text: true
    end

    describe 'default' do
      it "sets second button mouseout text to #{I18n.t('following')}" do
        render_inline(described_class.new(first_button: false))
        expect(rendered_component).to have_css '.btn_1', text: I18n.t('following'), exact_text: true
      end
    end
  end

  context 'second_button_mouseover_text' do
    it 'sets second button mouseout text' do
      render_inline(described_class.new(first_button: false, second_button_mouseover_text: 'Other Action Pinmapper!'))
      expect(rendered_component).to have_css ".btn_1[data-mouseoverout-mouseover-text-value='Other Action Pinmapper!']"
    end

    describe 'default' do
      it "sets second button mouseover text to #{I18n.t('following')}" do
        render_inline(described_class.new(first_button: false))
        expect(rendered_component).to have_css ".btn_1[data-mouseoverout-mouseover-text-value='#{I18n.t('unfollow')}']"
      end
    end
  end

  context 'second_button_class' do
    it 'sets second button class' do
      render_inline(described_class.new(first_button: false, second_button_class: 'btn_1 foo boo'))
      expect(rendered_component).to have_css '.btn_1.foo.boo'
    end

    describe 'default' do
      it 'sets class to "btn_1 rounded small"' do
        render_inline(described_class.new(first_button: false))
        expect(rendered_component).to have_css '.btn_1.rounded.small'
      end
    end
  end

  context 'second_button_path' do
    it 'sets second button path' do
      render_inline(described_class.new(first_button: false, second_button_path: unfollow_profile_path(id: user)))
      expect(rendered_component).to have_css "a.btn_1[href='#{unfollow_profile_path(id: user)}']"
    end

    describe 'default' do
      it 'sets path to "#"' do
        render_inline(described_class.new(first_button: false))
        expect(rendered_component).to have_css 'a.btn_1[href="#"]'
      end
    end
  end

  context 'display_block' do
    context 'when returning true' do
      it 'shows button' do
        render_inline(described_class.new(
                        display_block: lambda {
                          true
                        }
                      ))
        expect(rendered_component).to have_css '.btn_1'
      end
    end

    context 'when returning false' do
      it 'do not show button' do
        render_inline(described_class.new(
                        display_block: lambda {
                          false
                        }
                      ))
        expect(rendered_component).not_to have_css '.btn_1'
      end
    end
  end
end
