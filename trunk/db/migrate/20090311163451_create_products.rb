class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :width
      t.integer :depth
      t.integer :height
      t.string :code
      t.integer :product_range_id
      t.boolean :highlighted

      t.timestamps 
    end
  end

  def self.down
    drop_table :products
  end
end