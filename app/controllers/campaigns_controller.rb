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
    unless params[:start_date].present?
      params[:start_date] = Time.now
    end

    @campaign = Campaign.create(
      name:            params[:name],
      start_date:      params[:start_date],
      end_date:        params[:end_date]
    )
    unless @campaign.save
      message = @campaign.errors[:end_date].present? ? @campaign.errors[:end_date].to_sentence : nil
      if message.nil?
        message = @campaign.errors[:base].present? ? @campaign.errors[:base].to_sentence : nil
      end
      redirect_to action: :new, search: params[:search],
                                error: message,
                                name: params[:name],
                                start_date: params[:start_date],
                                end_date: params[:end_date]
      return
    end

    redirect_to action: :index, search: params[:search]
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])

    unless params[:start_date].present?
      params[:start_date] = @campaign.created_at
    end

    @campaign.update_attributes(
      name:            params[:name],
      status:          params[:camp_status].to_f,
      start_date:      params[:start_date],
      end_date:        params[:end_date]
    )
    unless @campaign.save
      message = @campaign.errors[:end_date].present? ? @campaign.errors[:end_date].to_sentence : nil
      if message.nil?
        message = @campaign.errors[:base].present? ? @campaign.errors[:base].to_sentence : nil
      end
      redirect_to action: :edit, id: params[:id],
                                  search: params[:search],
                                  error: message,
                                  name: params[:name],
                                  camp_status: params[:camp_status],
                                  start_date: params[:start_date],
                                  end_date: params[:end_date]
      return
    end

    redirect_to action: :index, search: params[:search]
  end

  def delete
    @campaign = Campaign.find(params[:id])
    units = Unit.where(campaign: @campaign)
    if units.any?
      alert = "No se puede borrar la campaña porque existen unidades asociadas a ella"
      redirect_to action: :edit, id: params[:id], search: params[:search], alert: alert
      return
    end

    @campaign.destroy
    redirect_to action: :index, search: params[:search]
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :status, :start_date, :end_date)
  end
end
