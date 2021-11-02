# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boards/show', type: :view do
  include Pagy::Backend
  let(:current_user) { create(:user, :confirmed) }
  let(:pagy_obj) do
    ar_pins = Pin.where(id: pins.pluck(:id))
    pagy(ar_pins).first
  end
  let(:board) { create(:board, user: current_user) }
  let(:pins) { create_list(:pin, 2) }

  before do
    board.pins << pins
    assign(:board, board)
    assign(:pins, pins)
    assign(:pagy, pagy_obj)
  end

  context 'when user not signed in' do
    before do
      render
    end

    it 'without follow/unfollow buton' do
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end
  end

  context 'renders board header when user signed in' do
    let(:new_board) { create(:board) }

    before do
      sign_in(current_user)
    end

    it 'do not show follow button when following board' do
      current_user.following_boards << new_board
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'do not show follow button when board owner is current_user' do
      current_user.following_boards << board
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 0
    end

    it 'show follow button when not following board' do
      assign(:board, new_board)
      render
      assert_select '.board-show > .header a.btn_1', text: I18n.t('follow'), count: 1
    end
  end

  context 'renders attributes of board (sign in not required)' do
    before do
      render
    end

    it '#name' do
      expect(rendered).to match(/#{board.name}/)
    end

    it 'renders a list of small pins' do
      assert_select '.small-pin .image', count: 2
      assert_select '.small-pin .body h6 a.black-link', count: 2
      assert_select '.small-pin .body small .black-link-555555', count: 2
      assert_select '.small-pin .body small.address', count: 2
      assert_select '.small-pin .body i.icon_pin_alt', count: 2
      assert_select '#infinite-pins.body'
    end
  end
end
