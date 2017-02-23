class Directory
  attr_reader :category, :platform, :language
  attr_reader :platform_slug, :category_slug, :language_slug
  def initialize(platform: :all, category: :all, language: :all)
    @category = category
    @platform = platform
    @language = language

    if [:all, nil].include? @platform
      @platform_slug = I18n.t('platform.all_slug')
    else
      @platform_slug = platform.code
    end
    if [:all, nil].include? @category
      @category_slug = I18n.t('category.all_slug')
    else
      @category_slug = I18n.t("category.list.#{category}")
    end
    if [:all, nil, I18n.t('language.all_slug')].include? @language
      @language_slug = I18n.t('language.all_slug')
    else
      @language_slug = I18n.t("language.list.#{language}")
    end
  end

  def path(page = nil)
    Rails.application.routes.url_helpers.directory_path(platform: platform_slug, language: language_slug, category: category_slug, page: page)
  end


end