class CampaignsController < ApplicationController
  
  respond_to :html, :js, :json

  def index
    if params[:search].present?
      @campaigns = Campaign.search(params[:search]).order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_campaigns = Campaign.search(params[:search])
    else
      @campaigns = Campaign.all.order('id DESC').paginate(:page => params[:page], :per_page => params[:per_page]||10)
      @unpaginated_campaigns = Campaign.all
    end

    respond_with(@campaigns) do |format|
      format.csv { send_data Campaign.to_csv(@unpaginated_campaigns), filename: "Campañas.csv" }
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
    units = Unit.where(campaign: @campaign)
    if units.any?
      alert = "No se puede borrar la campaña porque existen unidades asociadas a ella"
      redirect_to action: :edit, id: params[:id], alert: alert
      return
    end

    @campaign.destroy
    redirect_to action: :index
  end

  private

  def campaign_params
  params.require(:campaign).permit(:name, :status)
  end
end
