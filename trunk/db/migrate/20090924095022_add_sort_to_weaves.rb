class AddSortToWeaves < ActiveRecord::Migration
  def self.up
    add_column :weaves, :sort_order, :integer, :default => 0
  end

  def self.down
    drop_column :weaves, :sort_order
  end
end
