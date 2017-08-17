require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:campaign) { build(:campaign) }

  it 'is valid' do
    expect(campaign).to be_valid
  end
end
