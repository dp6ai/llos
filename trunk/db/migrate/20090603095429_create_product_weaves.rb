class CreateProductWeaves < ActiveRecord::Migration
  def self.up
    create_table :product_weaves do |t|
      t.integer :product_id
      t.integer :weave_id

      t.timestamps
    end
  end

  def self.down
    drop_table :product_weaves
  end
end
