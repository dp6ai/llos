class ProductHabtmAttributes < ActiveRecord::Migration
  def self.up
    create_table "product_attributes", :force => true do |t|
      t.column :product_id, :integer, :null => false
      t.column :product_attribute_field_id, :integer, :null => false
      t.column :value, :string, :null => false
    end

  end

  def self.down
    drop_table "product_attributes"
  end
end
