require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do

  let(:valid_attributes) {
    attributes_for :response
  }

  let(:invalid_attributes) {
    attributes_for :response, :invalid
  }

  describe "GET #index" do
    it 'assigns all responses as @responses' do
      response = Response.create! valid_attributes
      get :index
      expect(assigns(:responses)).to eq([response])
    end
  end

  describe "GET #show" do
    it 'assigns the user requested responses as @responses' do
      @user = FactoryGirl.create(:user)
      valid_attributes[:user_id] = @user.id
      response = Response.create! valid_attributes
      get :show, id: @user.id
      expect(assigns(:responses)).to eq([response])
    end
  end

end
