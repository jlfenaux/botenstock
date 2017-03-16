class BotsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, only: [:index, :destroy]
  before_action :set_bot, only: [:show, :edit, :update, :destroy]
  layout "admin"

  def logos
    @bots = Bot.all.order('created_at desc')
  end

  # GET /bots
  # GET /bots.json
  def index
    @bots = Bot.all
    @bots = @bots.where(status: params[:status]) unless params[:status].blank?
    @bots = @bots.where(" ? = ANY(categories)", params[:category]) unless params[:category].blank?
    @bots = @bots.joins(:platforms).where("platforms.provider_id = ?", params[:platform].to_i) unless params[:platform].blank?
    @bots = @bots.where(" ? = ANY(languages)", params[:language]) unless params[:language].blank?
    @bots = @bots.search_for(params[:keywords]) unless params[:keywords].blank?
    @bots = @bots.includes(platforms: :provider)
    @bots = @bots.order(:name).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /bots/1
  # GET /bots/1.json
  def show
    redirect_to bot_page_path(permalink: @bot.permalink)
  end

  # GET /bots/new
  def new
    @bot = Bot.new
    @bot.status = current_user.has_role?('admin') ? 'ok' : 'pending'
    add_platforms
    @translated_links = {}
    @translated_links[:en] = new_bot_en_path if I18n.locale != :en
    @translated_links[:fr] = new_bot_fr_path if I18n.locale != :fr

  end

  # GET /bots/1/edit
  def edit
    add_platforms
  end

  # POST /bots
  # POST /bots.json
  def create
    @bot = Bot.new(bot_params)

    respond_to do |format|
      if @bot.save
        format.html { redirect_to @bot, notice: 'Le bot a été créé.' }
        format.json { render :show, status: :created, location: @bot }
      else
        format.html { render :new }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bots/1
  # PATCH/PUT /bots/1.json
  def update
    respond_to do |format|
      if @bot.update(bot_params)
        format.html { redirect_to @bot, notice: 'Le bot a été mis à jour.' }
        format.json { render :show, status: :ok, location: @bot }
      else
        format.html { render :edit }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bots/1
  # DELETE /bots/1.json
  def destroy
    @bot.destroy
    respond_to do |format|
      format.html { redirect_to bots_url, notice: 'Le bot a été supprimé.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bot
      @bot = Bot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_params
      params.require(:bot).permit(
        :name,
        :status,
        :description_fr,
        :description_en,
        :tested_on,
        :test_fr,
        :test_en,
        :logo,
        :website,
        :twitter,
        :facebook,
        :tagline_en,
        :tagline_fr,
        :comments,
        :product_hunt_url,
        :venture_beat_url,
        categories: [],
        languages: [],
        platforms_attributes: [:url, :provider_id, :id]
      )
    end

    def add_platforms
      Provider.all.each do |provider|
        unless @bot.platforms.map(&:provider_id).include? provider.id
          @bot.platforms << Platform.new(provider_id: provider.id)
        end
      end
    end
end
