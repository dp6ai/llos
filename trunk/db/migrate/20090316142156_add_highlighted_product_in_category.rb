class AddHighlightedProductInCategory < ActiveRecord::Migration
  def self.up
    add_column :taggings, :highlighted, :boolean, :default => 0
  end

  def self.down
    remove_column :taggings, :highlighted
  end
end
