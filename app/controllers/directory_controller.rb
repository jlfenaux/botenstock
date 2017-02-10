class DirectoryController < ApplicationController

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
    @bots = @bots.where(" ? = ANY(languages)", @language) unless [nil, :all].include? @language
    @bots = @bots.search_for(params[:keywords]) unless params[:keywords].blank?
    @bots = @bots.includes(platforms: :provider)
    @bots = @bots.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @bot = Bot.where(permalink: params[:permalink]).includes(platforms: :provider).first

  end
  private
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
