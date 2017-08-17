require 'rails_helper'

RSpec.describe Response, type: :model do
  let(:response) { build(:response) }

  it 'is valid' do
    expect(response).to be_valid
  end
end
