require 'rails_helper'

describe Directory do
  describe "#initialize" do
    it "accepts no parameters" do
      dir = Directory.new
      expect(dir.category).to eq :all
      expect(dir.language).to eq :all
      expect(dir.platform).to eq :all
    end
    it "accepts platform as an object" do
      dir = Directory.new(platform: Platform.first)
      expect(dir.category).to eq :all
      expect(dir.language).to eq :all
      expect(dir.platform).to eq Platform.first
    end
  end
  describe "path" do
    it "works with no parameters" do
      I18n.locale = :en
      expect(Directory.new.path).to eq '/directory/all_platforms/all_categories/all_languages'
      I18n.locale = :fr
      expect(Directory.new.path).to eq '/fr/annuaire/toutes_les_plateformes/toutes_les_categories/toutes_les_langues'
    end
  end
end