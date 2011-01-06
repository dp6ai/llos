class Fabric < ActiveRecord::Base
  has_one :product_fabric

  named_scope :all_asc, :order => "name ASC"
end
