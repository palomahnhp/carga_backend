require 'rails_helper'

RSpec.describe Position, type: :model do
  let(:position) { build(:position) }

  it 'is valid' do
    expect(position).to be_valid
  end
end
