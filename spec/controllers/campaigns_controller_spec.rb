require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:valid_attributes) {
    attributes_for :campaign
  }

  let(:invalid_attributes) {
    attributes_for :campaign, :invalid
  }

  describe "GET #index" do
    it 'assigns all campaigns as @campaigns' do
      campaign = Campaign.create! valid_attributes
      get :index
      expect(assigns(:campaigns)).to eq([campaign])
    end
  end

  describe "GET #show" do
    it 'assigns the requested campaign as @campaign' do
      campaign = Campaign.create! valid_attributes
      get :show, id: campaign.to_param
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "GET #edit" do
    it 'assigns the requested campaign as @campaign' do
      campaign = Campaign.create! valid_attributes
      get :edit, id: campaign.to_param
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'creates a new Campaign' do
        expect {
          post :create, campaign: valid_attributes
        }.to change(Campaign, :count).by(1)
      end

      it 'assigns a newly created campaign as @campaign' do
        post :create, campaign: valid_attributes
        expect(assigns(:campaign)).to be_a(Campaign)
        expect(assigns(:campaign)).to be_persisted
      end

      it 'redirects to the created campaign' do
        post :create, campaign: valid_attributes
        expect(response).to redirect_to(campaigns_url)
      end
    end
  end

end
