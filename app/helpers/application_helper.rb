module ApplicationHelper

  def directory_link(name, platform: :all,category: :all ,language: :all, klass: '')
    platform = I18n.t('platform.all_slug') if [:all, nil].include? platform
    if [:all, nil].include? category
      category = I18n.t('category.all_slug')
    else
      category = I18n.t("category.list.#{category}")
    end
    if [:all, nil, I18n.t('language.all_slug')].include? language
      language = I18n.t('language.all_slug')
    else
      language = I18n.t("language.list.#{language}")
    end
    link_to name,
      bot_directory_path(platform: platform, language: language, category: category),
      class: klass
  end
end
