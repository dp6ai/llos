class AddDescriptionToProductRange < ActiveRecord::Migration
  def self.up
    add_column :product_ranges, :description, :text
  end

  def self.down
    remove_column :product_ranges, :description
  end
end
