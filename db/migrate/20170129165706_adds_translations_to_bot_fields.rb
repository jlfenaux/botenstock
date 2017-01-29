class AddsTranslationsToBotFields < ActiveRecord::Migration[5.0]
  def change
    add_column :bots, :tagline_en, :string
    add_column :bots, :description_en, :text
    rename_column :bots, :tagline, :tagline_fr
    rename_column :bots, :description, :description_fr
  end
end
