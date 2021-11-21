# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowServices::FollowUser do
  describe '#call' do
    subject(:followed) { described_class.call(follower, following) }

    let(:follower) { create(:user, :confirmed) }
    let(:following) { create(:user, :confirmed) }

    context 'response' do
      it { is_expected.to be_instance_of(Hash) }

      it 'has the success key' do
        expect(followed).to include(:success)
      end

      it 'has the payload key' do
        expect(followed).to include(:payload)
      end

      context 'when there is an error' do
        let(:result) { described_class.call(nil, nil) }

        it 'has no the payload key' do
          expect(result).not_to include(:payload)
        end

        it 'has the error key' do
          expect(result).to include(:error)
        end
      end

      context 'when arguments are nil' do
        it 'to not be a success' do
          result = described_class.call(nil, nil)
          expect(result[:success]).to be(false)
        end
      end

      context 'when arguments are valid' do
        it 'to be a success' do
          expect(followed[:success]).to be(true)
        end
      end
    end

    context 'success' do
      before do
        followed
      end

      it 'follows' do
        expect(follower.following).to include(following)
      end

      it 'is followed' do
        expect(following.followers).to include(follower)
      end
    end
  end
end
