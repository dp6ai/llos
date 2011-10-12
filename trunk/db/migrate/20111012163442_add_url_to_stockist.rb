class AddUrlToStockist < ActiveRecord::Migration
  def self.up
    add_column :stockists, :url, :string
  end

  def self.down
    remove_column :stockists, :url
  end
end
