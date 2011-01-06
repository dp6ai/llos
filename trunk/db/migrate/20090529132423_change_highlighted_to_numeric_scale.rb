class ChangeHighlightedToNumericScale < ActiveRecord::Migration
  def self.up
    change_column(:products, :highlighted, :integer)
    change_column(:taggings, :highlighted, :integer)
  end

  def self.down
  end
end
