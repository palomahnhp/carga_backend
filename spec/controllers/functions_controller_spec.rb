require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do

  let(:valid_attributes) {
    attributes_for :function
  }

  let(:invalid_attributes) {
    attributes_for :function, :invalid
  }

  describe "GET #index" do
    it 'assigns all functions as @functions' do
      function = Function.create! valid_attributes
      get :index
      expect(assigns(:functions)).to eq([function])
    end
  end

  describe "GET #show" do
    it 'assigns the requested function as @function' do
      function = Function.create! valid_attributes
      get :show, id: function.to_param
      expect(assigns(:function)).to eq(function)
    end
  end

  describe "GET #edit" do
    it 'assigns the requested function as @function' do
      function = Function.create! valid_attributes
      get :edit, id: function.to_param
      expect(assigns(:function)).to eq(function)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'creates a new Function' do
        expect {
          post :create, function: valid_attributes
        }.to change(Function, :count).by(1)
      end

      it 'assigns a newly created function as @function' do
        post :create, function: valid_attributes
        expect(assigns(:function)).to be_a(Function)
        expect(assigns(:function)).to be_persisted
      end

      it 'redirects to the created function' do
        post :create, function: valid_attributes
        expect(response).to redirect_to(functions_url)
      end
    end
  end

end
