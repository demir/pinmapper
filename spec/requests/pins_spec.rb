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

RSpec.describe '/pins', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:pin) { create(:pin, user: user) }

  context 'specs without sign in' do
    describe 'GET /index' do
      it 'renders a successful response' do
        create(:pin)
        get pins_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get pin_url(pin)
        expect(response).to be_successful
      end
    end
  end

  context 'specs with sign in' do
    before do
      sign_in(user)
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_pin_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        get edit_pin_url(pin)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Pin' do
          expect do
            post pins_url, params: { pin: attributes_for(:pin) }
          end.to change(Pin, :count).by(1)
        end

        it 'redirects to the created pin' do
          post pins_url, params: { pin: attributes_for(:pin) }
          expect(response).to redirect_to(pin_url(Pin.last))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Pin' do
          expect do
            post pins_url, params: { pin: attributes_for(:pin, :invalid) }
          end.to change(Pin, :count).by(0)
        end

        it 'renders new template' do
          post pins_url, params: { pin: attributes_for(:pin, :invalid) }
          expect(response).to have_http_status(:unprocessable_entity)
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        it 'updates the requested pin' do
          patch pin_url(pin), params: { pin: attributes_for(:pin, name: 'OMÜ') }
          pin.reload
          expect(pin.name).to match('OMÜ')
        end

        it 'redirects to the pin' do
          patch pin_url(pin), params: { pin: attributes_for(:pin, name: 'OMÜ') }
          pin.reload
          expect(response).to redirect_to(pin_url(pin))
        end
      end

      context 'with invalid parameters' do
        it 'renders a successful response' do
          patch pin_url(id: pin), params: { pin: attributes_for(:pin, :invalid) }
          assert_select 'div[class="alert alert-danger"]',
                        text: I18n.t('simple_form.error_notification.default_message')
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested pin' do
        new_pin = create(:pin, user: user)
        expect do
          delete pin_url(new_pin)
        end.to change(Pin, :count).by(-1)
      end

      it 'redirects to the pins list' do
        new_pin = create(:pin, user: user)
        delete pin_url(new_pin)
        expect(response).to redirect_to(pins_url)
      end
    end
  end
end
