class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  belongs_to :product

  named_scope :products_with, lambda { |tag_id| { :conditions => ["taggable_type = 'Product' AND tag_id = ?", tag_id], :order => "highlighted DESC" } }
end
