class ProductFabric < ActiveRecord::Base
  belongs_to :product
  belongs_to :fabric
end
