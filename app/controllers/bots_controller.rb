class BotsController < ApplicationController
  before_action :set_bot, only: [:show, :edit, :update, :destroy]

  # GET /bots
  # GET /bots.json
  def index


    @title = []
    @title <<  params[:platform].gsub('_', ' ') if params[:platform] && (params[:platform] != 'toutes_les_plateformes')
    @title <<  params[:category] if params[:category] != 'toutes_les_catégories'
    @title <<  params[:language] if params[:language] != 'toutes_les_langues'
    @title = @title.compact.join(' / ')
    @category = params[:category] || 'toutes_les_catégories'
    @platform = params[:platform] || 'toutes_les_plateformes'
    @language = params[:language] || 'toutes_les_langues'

    @bots = Bot.all
    @bots = @bots.where(" ? = ANY(categories)", params[:category]) unless [nil, 'toutes_les_catégories'].include? params[:category]
    @bots = @bots.where(" ? = ANY(platforms)", params[:platform]) unless [nil, 'toutes_les_plateformes'].include? params[:platform]
    @bots = @bots.where(" ? = ANY(languages)", params[:language]) unless [nil, 'toutes_les_langues'].include? params[:language]
    @bots = @bots.search_for(params[:keywords]) unless params[:keywords].blank?
    @bots = @bots.paginate(:page => params[:page], :per_page => 10)

  end

  # GET /bots/1
  # GET /bots/1.json
  def show
  end

  # GET /bots/new
  def new
    @bot = Bot.new
  end

  # GET /bots/1/edit
  def edit
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
      # @bot = Bot.find(params[:id])
      @bot = Bot.where(permalink: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_params
      params.require(:bot).permit(:name, :description, :logo, :website, :twitter, :facebook, :tagline, :product_hunt_url, :venture_beat_url, :amazon_echo_url, :android_url, :discord_url, :email_url, :imessage_url, :ios_url, :kik_url, :messenger_url, :skype_url, :slack_url, :sms_url, :telegram_url, :twitter_url, :web_url, platforms: [], categories: [], languages: [])
    end
end
