class HomepageController < ApplicationController
  def index
    set_meta_tags description: I18n.locale == :fr ? "Botsforchatting est un annuaire de bots indépendant recensant et testant tous les bots, sur toutes les plates-formes." : "Botsforchatting is an independent bots directory listing and testing all bots on all platforms."
    @translated_links = {}
    @translated_links[:en] = root_en_path if I18n.locale != :en
    @translated_links[:fr] = root_fr_path if I18n.locale != :fr
    set_meta_tags alternate: @translated_links
  end
end