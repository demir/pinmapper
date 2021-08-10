# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowServices::FollowUser do
  describe '#call' do
    subject { described_class.call(follower, following) }

    let(:follower) { create(:user, :confirmed) }
    let(:following) { create(:user, :confirmed) }

    context 'response' do
      it { is_expected.to be_instance_of(OpenStruct) }

      it 'has the success? method' do
        expect(subject).to respond_to(:success?)
      end

      it 'has the payload method' do
        expect(subject).to respond_to(:payload)
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
          expect(subject.success?).to be(true)
        end
      end
    end

    context 'success' do
      before do
        subject
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
