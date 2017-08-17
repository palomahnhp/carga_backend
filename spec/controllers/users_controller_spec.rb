require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    attributes_for :user
  }

  let(:invalid_attributes) {
    attributes_for :user, :invalid
  }

  describe "GET #index" do
    it 'assigns all users as @users' do
      user = User.create! valid_attributes
      get :index
      expect(assigns(:users)).to include(user)
    end
  end

  describe "GET #show" do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, id: user.to_param
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #edit" do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, id: user.to_param
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, user: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, user: valid_attributes
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, user: valid_attributes
        expect(response).to redirect_to(users_url)
      end
    end
  end

end
