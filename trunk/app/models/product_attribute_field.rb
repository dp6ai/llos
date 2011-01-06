class ProductAttributeField < ActiveRecord::Base
  acts_as_friendly_param :name
  has_one :product_attribute

  named_scope :all_asc, :order => "name ASC"
end