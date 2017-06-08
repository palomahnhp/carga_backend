class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def create
    @campaign = Campaign.create(name: params[:name])
    if @campaign.save
      puts 'campaign saved'
    end
    redirect_to action: :index
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.update_attributes(name: params[:name])
    redirect_to action: :index
  end

  def delete
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to action: :index
  end

  private

  def campaign_params
  params.require(:campaign).permit(:name, :active, :pending, :completed)
  end
end
