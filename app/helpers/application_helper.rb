module ApplicationHelper

  def directory_link(name, platform: :all,category: :all ,language: :all, klass: '')
     link_to name,
        Directory.new(platform: platform, category: category ,language: language).path,
        class: klass
  end

end
