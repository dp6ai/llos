class LocalizeTag < ActiveRecord::Migration
  def self.up
    Tag.create_translation_table! :name => :string, :kind => :text
  end

  def self.down
    Tag.drop_translation_table!
  end
end
