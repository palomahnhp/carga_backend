require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { build(:unit) }

  it 'is valid' do
    expect(unit).to be_valid
  end
end
