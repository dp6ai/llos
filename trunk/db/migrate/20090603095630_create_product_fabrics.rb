class CreateProductFabrics < ActiveRecord::Migration
  def self.up
    create_table :product_fabrics do |t|

      t.integer :product_id
      t.integer :fabric_id

      t.timestamps
    end
  end

  def self.down
    drop_table :product_fabrics
  end
end
