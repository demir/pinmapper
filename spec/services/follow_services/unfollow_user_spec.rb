# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowServices::UnfollowUser do
  describe '#call' do
    subject(:unfollowed) do
      FollowServices::FollowUser.call(follower, following)
      described_class.call(follower, following)
    end

    let(:follower) { create(:user, :confirmed) }
    let(:following) { create(:user, :confirmed) }

    context 'response' do
      it { is_expected.to be_instance_of(OpenStruct) }

      it 'has the success? method' do
        expect(unfollowed).to respond_to(:success?)
      end

      it 'has the payload method' do
        expect(unfollowed).to respond_to(:payload)
      end

      context 'when there is an error' do
        let(:result) { described_class.call(nil, nil) }

        it 'has no the payload method' do
          expect(result).not_to respond_to(:payload)
        end

        it 'has the error method' do
          expect(result).to respond_to(:error)
        end
      end

      context 'when arguments are nil' do
        it 'to not be a success' do
          result = described_class.call(nil, nil)
          expect(result.success?).to be(false)
        end
      end

      context 'when arguments are valid' do
        it 'to be a success' do
          expect(unfollowed.success?).to be(true)
        end
      end
    end

    context 'success' do
      before do
        unfollowed
      end

      it 'unfollows' do
        expect(follower.following).not_to include(following)
      end

      it 'is unfollowed' do
        expect(following.followers).not_to include(follower)
      end
    end
  end
end
