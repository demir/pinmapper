# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmniauthServices::Google, type: :service do
  describe '#call' do
    subject(:response) { described_class.call(auth) }

    let(:auth) { create(:auth_hash, :google) }

    context 'response' do
      it { is_expected.to be_instance_of(Hash) }

      it 'has the success key' do
        expect(response).to include(:success)
      end

      it 'has the payload key' do
        expect(response).to include(:payload)
      end

      context 'when there is an error' do
        let(:result) { described_class.call(nil) }

        it 'has no the payload key' do
          expect(result).not_to include(:payload)
        end

        it 'has the error key' do
          expect(result).to include(:error)
        end
      end

      context 'when arguments are nil' do
        it 'to not be a success' do
          result = described_class.call(nil)
          expect(result[:success]).to be(false)
        end
      end

      context 'when arguments are valid' do
        it 'to be a success' do
          expect(response[:success]).to be(true)
        end
      end
    end

    context 'success' do
      before do
        User.where(email: 'testuser@gmail.com').destroy_all
      end

      it 'return user' do
        user = response[:payload]
        expect(user&.email).to eq('testuser@gmail.com')
      end

      it 'attach avatar' do
        user = response[:payload]
        expect(user.profile.avatar.attached?).to be true
      end
    end
  end
end
