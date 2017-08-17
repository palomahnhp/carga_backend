require 'rails_helper'

RSpec.describe UnitsController, type: :controller do

  let(:valid_attributes) {
    attributes_for :unit
  }

  let(:invalid_attributes) {
    attributes_for :unit, :invalid
  }

  describe "GET #index" do
    it 'assigns all units as @units' do
      unit = Unit.create! valid_attributes
      get :index
      expect(assigns(:units)).to include(unit)
    end
  end

  describe "GET #show" do
    it 'assigns the requested unit as @unit' do
      unit = Unit.create! valid_attributes
      get :show, id: unit.to_param
      expect(assigns(:unit)).to eq(unit)
    end
  end

  describe "GET #edit" do
    it 'assigns the requested unit as @unit' do
      unit = Unit.create! valid_attributes
      get :edit, id: unit.to_param
      expect(assigns(:unit)).to eq(unit)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'creates a new Unit' do
        expect {
          post :create, unit: valid_attributes
        }.to change(Unit, :count).by(1)
      end

      it 'assigns a newly created unit as @unit' do
        post :create, unit: valid_attributes
        expect(assigns(:unit)).to be_a(Unit)
        expect(assigns(:unit)).to be_persisted
      end

      it 'redirects to the created unit' do
        post :create, unit: valid_attributes
        expect(response).to redirect_to(units_url)
      end
    end
  end

end
