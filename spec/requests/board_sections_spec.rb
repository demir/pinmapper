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

RSpec.describe '/board_sections', type: :request do
  let(:current_user) { create(:user, :confirmed) }
  let(:board) { create(:board, user: current_user) }
  let(:board_section) { create(:board_section, board:) }
  let(:headers) { { 'HTTP_ACCEPT_LANGUAGE' => 'en-US,en;q=0.9' } }

  context 'with current_user' do
    before do
      sign_in(current_user)
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get board_section_url(id: board_section), headers: headers
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_board_board_section_url(board, locale: I18n.locale), headers: headers
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        get edit_board_section_url(id: board_section), headers: headers
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Board Section' do
          expect do
            post board_board_sections_url(board, locale: I18n.locale),
                 params:  { board_section: attributes_for(:board_section) },
                 headers:
          end.to change(Board, :count).by(1)
        end

        it 'redirects to the created board section' do
          post board_board_sections_url(board, locale: I18n.locale),
               params:  { board_section: attributes_for(:board_section) },
               headers: headers
          expect(response).to redirect_to(board_url(board))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Board Section' do
          expect do
            post board_board_sections_url(board, locale: I18n.locale),
                 params:  { board_section: attributes_for(:board_section, :invalid) },
                 headers:
          end.not_to change(BoardSection, :count)
        end

        it 'renders new template' do
          post board_board_sections_url(board, locale: I18n.locale),
               params:  { board_section: attributes_for(:board_section, :invalid) },
               headers: headers
          expect(response).to have_http_status(:unprocessable_entity)
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        it 'updates the requested board section' do
          patch board_section_url(id: board_section),
                params:  { board_section: attributes_for(:board_section, name: 'Pinmapper!!') },
                headers: headers
          board_section.reload
          expect(board_section.name).to match('Pinmapper!!')
        end

        it 'redirects to the board section' do
          patch board_section_url(id: board_section),
                params:  { board_section: attributes_for(:board_section, name: 'Pinmapper!!') },
                headers: headers
          board_section.reload
          expect(response).to redirect_to(board_url(board))
        end
      end

      context 'with invalid parameters' do
        it 'renders a successful response' do
          patch board_section_url(id: board_section),
                params:  { board_section: attributes_for(:board_section, :invalid) },
                headers: headers
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested board section' do
        new_board = create(:board, user: current_user)
        new_board_section = create(:board_section, board: new_board)
        expect do
          delete board_section_url(id: new_board_section), headers:
        end.to change(BoardSection, :count).by(-1)
      end

      it 'redirects to the board section' do
        new_board = create(:board, user: current_user)
        new_board_section = create(:board_section, board: new_board)
        delete board_section_url(id: new_board_section), headers: headers
        expect(response).to redirect_to(board_url(new_board))
      end
    end

    describe 'add pin to board section' do
      let(:pin) { create(:pin) }

      context 'already added to board section' do
        before do
          board_section.pins << pin
        end

        it 'raises validation error #add_pin' do
          expect  do
            get add_pin_board_section_url(id: board_section, pin_id: pin), headers:
          end.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'render a successful response #remove_pin' do
          get remove_pin_board_section_url(id: board_section, pin_id: pin), headers: headers
          expect(response).to be_successful
        end
      end

      context 'not added to board section' do
        it 'render a successful response #add_pin' do
          get add_pin_board_section_url(id: board_section, pin_id: pin), headers: headers
          expect(response).to be_successful
        end

        it 'render a successful response #remove_pin' do
          get remove_pin_board_section_url(id: board_section, pin_id: pin), headers: headers
          expect(response).to be_successful
        end
      end
    end
  end

  context 'without current_user' do
    describe 'GET /show' do
      context 'secret board section' do
        it 'can not renders a successful response' do
          new_board = create(:board, privacy: 'secret')
          new_board_section = create(:board_section, board: new_board)
          get board_section_url(id: new_board_section), headers: headers
          expect(response).not_to be_successful
        end
      end

      context 'public board section' do
        it 'renders a successful response' do
          get board_section_url(id: board_section), headers: headers
          expect(response).to be_successful
        end
      end
    end

    describe 'GET /new' do
      it 'can not renders a successful response' do
        get new_board_board_section_url(board, locale: I18n.locale), headers: headers
        expect(response).not_to be_successful
      end
    end

    describe 'GET /edit' do
      it 'can not render a successful response' do
        get edit_board_section_url(id: board_section), headers: headers
        expect(response).not_to be_successful
      end
    end

    it 'can not POST /create' do
      expect do
        post board_board_sections_url(board, locale: I18n.locale),
             params:  { board_section: attributes_for(:board_section) },
             headers:
      end.not_to change(BoardSection, :count)
    end

    it 'can not PATCH /update' do
      patch board_section_url(id: board_section),
            params:  { board_section: attributes_for(:board_section, name: 'Pinmapper!!') },
            headers: headers
      board_section.reload
      expect(board_section.name).not_to match('Pinmapper!!')
    end

    it 'can not DELETE /destroy' do
      new_board = create(:board, user: current_user)
      new_board_section = create(:board_section, board: new_board)
      expect do
        delete board_section_url(id: new_board_section), headers:
      end.not_to change(BoardSection, :count)
    end

    describe 'add pin to board section' do
      let(:pin) { create(:pin) }

      describe '#add_pin' do
        it 'not renders a successful response' do
          get add_pin_board_section_url(id: board_section, pin_id: pin), headers: headers
          expect(response).not_to be_successful
        end
      end

      describe '#remove_pin' do
        it 'not renders a successful response' do
          get remove_pin_board_section_url(id: board_section, pin_id: pin), headers: headers
          expect(response).not_to be_successful
        end
      end
    end
  end
end
