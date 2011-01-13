class RemoveTagKindTranslation < ActiveRecord::Migration
  def self.up
    remove_column :tag_translations, :kind
  end

  def self.down
  end
end
