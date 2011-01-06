class CreateProductRanges < ActiveRecord::Migration
  def self.up
    create_table :product_ranges do |t|
      t.string :name

      t.timestamps 
    end
  end

  def self.down
    drop_table :product_ranges
  end
end