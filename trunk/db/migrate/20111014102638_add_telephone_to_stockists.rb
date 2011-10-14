class AddTelephoneToStockists < ActiveRecord::Migration
  def self.up
    add_column :stockists, :telephone, :string
  end

  def self.down
    remove_column :stockists, :telephone
  end
end
