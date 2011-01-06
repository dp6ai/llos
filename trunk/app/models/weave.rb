class Weave < ActiveRecord::Base
  has_one :product_weave

  named_scope :all_asc, :order => "name ASC"
  named_scope :all_by_sort_order_asc, :order => "sort_order ASC"
end
