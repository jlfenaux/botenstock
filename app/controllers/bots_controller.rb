class BotsController < ApplicationController
  before_action :set_bot, only: [:show, :edit, :update, :destroy]

  # GET /bots
  # GET /bots.json
  def index
    @category = get_category
    @platform = get_platform
    @language = get_language

    @title = []
    @title <<  I18n.t("category.list.#{@category}") unless @category == :all
    @title <<  @platform.name unless @platform == :all
    @title <<  I18n.t("language.list.#{@language}") unless @language == :all

    @title = @title.empty? ? I18n.t('default_title') : @title.compact.join(' / ')

    @bots = Bot.all
    @bots = @bots.where(" ? = ANY(categories)", @category) unless [nil, :all].include? @category
    @bots = @bots.joins(:platforms).where("platforms.provider_id = ?", @platform.id) unless @platform == :all
    @bots = @bots.where(" ? = ANY(languages)", params[:language]) unless [nil, :all].include? @language
    @bots = @bots.search_for(params[:keywords]) unless params[:keywords].blank?
    @bots = @bots.includes(platforms: :provider)
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
    Provider.all.each do |provider|
      unless @bot.platforms.map(&:provider_id).include? provider.id
        @bot.platforms << Platform.new(provider_id: provider.id)
      end
    end
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
      @bot = Bot.where(permalink: params[:id]).includes(platforms: :provider).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_params
      params.require(:bot).permit(:name, :description_fr, :description_en, :logo, :website, :twitter, :facebook, :tagline_en, :tagline_fr, :product_hunt_url, :venture_beat_url, :amazon_echo_url, :android_url, :discord_url, :email_url, :imessage_url, :ios_url, :kik_url, :messenger_url, :skype_url, :slack_url, :sms_url, :telegram_url, :twitter_url, :web_url, categories: [], languages: [], platforms_attributes: [:url, :id])
    end

    def get_category
      return :all if params[:category].blank?
      return :all if params[:category] == I18n.t('category.all_slug', locale: I18n.locale)
      I18n.t('category.list', locale: I18n.locale).invert[params[:category]]
    end
    def get_platform
      return :all if params[:platform].nil?
      return :all if params[:platform] == I18n.t('platform.all_slug', locale: I18n.locale)
      Provider.where(code: params[:platform]).first
    end
    def get_language
      return :all if params[:language].blank?
      return :all if params[:language] == I18n.t('language.all_slug', locale: I18n.locale)
      I18n.t('language.list', locale: I18n.locale).invert[params[:language]]
    end
end
