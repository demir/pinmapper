# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/boards', type: :request do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  context 'with current_user' do
    before do
      sign_in(current_user)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        get boards_url, headers: headers
        expect(response).to be_successful
      end
    end

    it 'GET /following_boards' do
      get following_boards_boards_path, headers: headers
      expect(response).to be_successful
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get board_url(id: board), headers: headers
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_board_url, headers: headers
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        get edit_board_url(id: board), headers: headers
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Board' do
          expect do
            post boards_url, params: { board: attributes_for(:board) }, headers:
          end.to change(Board, :count).by(1)
        end

        it 'redirects to the created board' do
          post boards_url, params: { board: attributes_for(:board) }, headers: headers
          expect(response).to redirect_to(boards_url)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Board' do
          expect do
            post boards_url, params: { board: attributes_for(:board, :invalid) }, headers:
          end.not_to change(Board, :count)
        end

        it 'renders new template' do
          post boards_url, params: { board: attributes_for(:board, :invalid) }, headers: headers
          expect(response).to have_http_status(:unprocessable_entity)
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        it 'updates the requested board' do
          patch board_url(id: board), params: { board: attributes_for(:board, name: 'Pinmapper!!') }, headers: headers
          board.reload
          expect(board.name).to match('Pinmapper!!')
        end

        it 'redirects to the index' do
          patch board_url(id: board), params: { board: attributes_for(:board, name: 'Pinmapper!!') }, headers: headers
          board.reload
          expect(response).to redirect_to(boards_url)
        end
      end

      context 'with invalid parameters' do
        it 'renders a successful response' do
          patch board_url(id: board), params: { board: attributes_for(:board, :invalid) }, headers: headers
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested board' do
        new_board = create(:board, user: current_user)
        expect do
          delete board_url(id: new_board), headers:
        end.to change(Board, :count).by(-1)
      end

      it 'redirects to the boards list' do
        new_board = create(:board, user: current_user)
        delete board_url(id: new_board), headers: headers
        expect(response).to redirect_to(boards_url)
      end
    end

    describe 'add pin to board' do
      let(:pin) { create(:pin) }

      describe '#add_to_board_list' do
        it 'render a successful response' do
          get add_to_board_list_boards_path(pin_id: pin), headers: headers
          expect(response).to be_successful
        end
      end

      context 'already added to board' do
        before do
          board.pins << pin
        end

        it 'raises validation error #add_pin' do
          expect  do
            get add_pin_board_path(id: board, pin_id: pin), headers:
          end.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'render a successful response #remove_pin' do
          get remove_pin_board_path(id: board, pin_id: pin, format: :turbo_stream), headers: headers
          expect(response).to be_successful
        end
      end

      context 'not added to board' do
        it 'render a successful response #add_pin' do
          get add_pin_board_path(id: board, pin_id: pin, format: :turbo_stream), headers: headers
          expect(response).to be_successful
        end

        it 'render a successful response #remove_pin' do
          get remove_pin_board_path(id: board, pin_id: pin, format: :turbo_stream), headers: headers
          expect(response).to be_successful
        end
      end
    end
  end

  context 'without current_user' do
    describe 'GET /index' do
      it 'can not renders a successful response' do
        get boards_url, headers: headers
        expect(response).not_to be_successful
      end
    end

    describe 'GET /show' do
      context 'secret board' do
        it 'can not renders a successful response' do
          new_board = create(:board, privacy: 'secret')
          get board_url(id: new_board), headers: headers
          expect(response).not_to be_successful
        end
      end

      context 'public board' do
        it 'renders a successful response' do
          get board_url(id: board), headers: headers
          expect(response).to be_successful
        end
      end
    end

    describe 'GET /new' do
      it 'can not renders a successful response' do
        get new_board_url, headers: headers
        expect(response).not_to be_successful
      end
    end

    describe 'GET /edit' do
      it 'can not render a successful response' do
        get edit_board_url(id: board), headers: headers
        expect(response).not_to be_successful
      end
    end

    it 'can not POST /create' do
      expect do
        post boards_url, params: { board: attributes_for(:board) }, headers:
      end.not_to change(Board, :count)
    end

    it 'can not PATCH /update' do
      patch board_url(id: board), params: { board: attributes_for(:board, name: 'Pinmapper!!') }, headers: headers
      board.reload
      expect(board.name).not_to match('Pinmapper!!')
    end

    it 'can not DELETE /destroy' do
      new_board = create(:board, user: current_user)
      expect do
        delete board_url(id: new_board), headers:
      end.not_to change(Board, :count)
    end

    describe 'add pin to board' do
      let(:pin) { create(:pin) }

      describe '#add_to_board_list' do
        it 'not renders a successful response' do
          get add_to_board_list_boards_path(pin_id: pin), headers: headers
          expect(response).not_to be_successful
        end
      end

      describe '#add_pin' do
        it 'not renders a successful response' do
          get add_pin_board_path(id: board, pin_id: pin), headers: headers
          expect(response).not_to be_successful
        end
      end

      describe '#remove_pin' do
        it 'not renders a successful response' do
          get remove_pin_board_path(id: board, pin_id: pin), headers: headers
          expect(response).not_to be_successful
        end
      end
    end

    it 'can not GET /following_boards' do
      get following_boards_boards_path, headers: headers
      expect(response).not_to be_successful
    end
  end
end
