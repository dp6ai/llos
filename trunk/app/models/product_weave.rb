class ProductWeave < ActiveRecord::Base
  belongs_to :product
  belongs_to :weave
end
