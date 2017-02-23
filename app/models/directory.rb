class Directory
  attr_reader :category, :platform, :language
  attr_reader :platform_slug, :category_slug, :language_slug
  def initialize(platform: :all, category: :all, language: :all, locale: I18n.locale)
    @category = category
    @platform = platform
    @language = language
    @locale = locale

    if [:all, nil].include? @platform
      @platform_slug = I18n.t('platform.all_slug', locale: locale)
    else
      @platform_slug = platform.code
    end
    if [:all, nil].include? @category
      @category_slug = I18n.t('category.all_slug', locale: locale)
    else
      @category_slug = I18n.t("category.list.#{category}", locale: locale)
    end
    if [:all, nil, I18n.t('language.all_slug', locale: locale)].include? @language
      @language_slug = I18n.t('language.all_slug', locale: locale)
    else
      @language_slug = I18n.t("language.list.#{language}", locale: locale)
    end
  end

  def path(page = nil)
    case @locale
    when :en
      Rails.application.routes.url_helpers.directory_en_path(platform: platform_slug, language: language_slug, category: category_slug, page: (page && page > 1) ? page : nil )
    when :fr
      Rails.application.routes.url_helpers.directory_fr_path(platform: platform_slug, language: language_slug, category: category_slug, page:  (page && page > 1) ? page : nil)
    end

  end


end