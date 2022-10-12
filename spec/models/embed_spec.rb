# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Embed, type: :model do
  subject(:embed) { create(:embed, :video) }

  it 'has a valid factory for video' do
    expect(embed).to be_valid
  end

  it 'has a valid factory for not video' do
    not_video_embed = create(:embed, :not_video)
    expect(not_video_embed).to be_valid
  end

  it 'has attachable sgid' do
    expect(embed&.attachable_sgid).not_to be_nil
  end
end
