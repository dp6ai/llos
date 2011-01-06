class LocalizePr < ActiveRecord::Migration
  def self.up
    ProductRange.create_translation_table! :name => :string, :description => :text
  end

  def self.down
    ProductRange.drop_translation_table!
  end
end
