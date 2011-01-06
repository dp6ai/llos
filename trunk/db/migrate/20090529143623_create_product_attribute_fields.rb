class CreateProductAttributeFields < ActiveRecord::Migration
  def self.up
    create_table :product_attribute_fields do |t|
      t.string :name

      t.timestamps 
    end
    ProductAttributeField.create(:name => "Width")
    ProductAttributeField.create(:name => "Height")
    ProductAttributeField.create(:name => "Depth")
    ProductAttributeField.create(:name => "Seat Height")
    ProductAttributeField.create(:name => "Seat Diameter")
    ProductAttributeField.create(:name => "Diameter")
    ProductAttributeField.create(:name => "Length")
    ProductAttributeField.create(:name => "Width x Width")
    ProductAttributeField.create(:name => "Headboard Height")
    ProductAttributeField.create(:name => "Footboard Height")
    ProductAttributeField.create(:name => "Siderail Height")
  end

  def self.down
    drop_table :product_attribute_fields
  end
end

