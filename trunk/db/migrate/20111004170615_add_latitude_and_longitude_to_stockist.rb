class AddLatitudeAndLongitudeToStockist < ActiveRecord::Migration
  def self.up
    add_column :stockists, :latitude, :float
    add_column :stockists, :longitude, :float
  end

  def self.down
    remove_column :stockists, :longitude
    remove_column :stockists, :latitude
  end
end
