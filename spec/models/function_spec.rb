require 'rails_helper'

RSpec.describe Function, type: :model do
  let(:function) { build(:function) }

  it 'is valid' do
    expect(function).to be_valid
  end
end
