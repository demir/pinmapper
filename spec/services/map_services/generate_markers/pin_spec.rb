# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapServices::GenerateMarkers::Pin, type: :service do
  let(:pins_array) { create_list(:pin, 2) }
  let(:pins) { Pin.where(id: pins_array.pluck(:id)) }

  describe '#call' do
    subject(:response) { described_class.call(pins) }

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
      let(:payload) { response[:payload] }

      it 'payload is an array' do
        expect(payload).to be_instance_of(Array)
      end

      it 'items count of array' do
        expect(payload.length).to eq pins.length
      end

      it 'keys of element in array' do
        item = payload.first
        expect(item.keys).to eq %i[id latitude longitude popup]
      end
    end
  end
end
