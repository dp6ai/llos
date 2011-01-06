class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_field

  def to_s
    self.value
  end
end
