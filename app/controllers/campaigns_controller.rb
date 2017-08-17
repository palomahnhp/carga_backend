class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
    if params[:search]
      @campaigns = Campaign.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    else
      @campaigns = Campaign.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def create
    @campaign = Campaign.create(name: params[:name], status: params[:status].to_f)
    @campaign.save

    redirect_to action: :index
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.update_attributes(name: params[:name], status: params[:status].to_f)
    redirect_to action: :index
  end

  def delete
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to action: :index
  end

  private

  def campaign_params
  params.require(:campaign).permit(:name, :status)
  end
end
