require 'rails_helper'

RSpec.describe PositionsController, type: :controller do

  let(:valid_attributes) {
    attributes_for :position
  }

  let(:invalid_attributes) {
    attributes_for :position, :invalid
  }

  describe "GET #index" do
    it 'assigns all positions as @positions' do
      position = Position.create! valid_attributes
      get :index
      expect(assigns(:positions)).to eq([position])
    end
  end

  describe "GET #show" do
    it 'assigns the requested position as @position' do
      position = Position.create! valid_attributes
      get :show, id: position.to_param
      expect(assigns(:position)).to eq(position)
    end
  end

  describe "GET #edit" do
    it 'assigns the requested position as @position' do
      position = Position.create! valid_attributes
      get :edit, id: position.to_param
      expect(assigns(:position)).to eq(position)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'creates a new Position' do
        expect {
          @unit = FactoryGirl.create(:unit)
          valid_attributes[:unit_id] = @unit.id
          position = Position.create! valid_attributes
        }.to change(Position, :count).by(1)
      end

      it 'assigns a newly created position as @position' do
        post :create, position: valid_attributes
        expect(assigns(:position)).to be_a(Position)
        position = Position.create! valid_attributes
        expect(position).to be_persisted
      end

      it 'redirects to the created position' do
        post :create, position: valid_attributes
        expect(response).to redirect_to(positions_url)
      end
    end
  end

end
