class Product < ActiveRecord::Base
  belongs_to :product_range
  has_many :product_attributes, :dependent => :destroy
  has_many :product_weaves, :dependent => :destroy
  has_many :product_fabrics, :dependent => :destroy
  is_taggable :type, :room, :outdoor


  has_attached_file :image,
                    :styles => { :medium => "480x320>",
                                 :thumb => "144x96>" }

  validates_presence_of :code, :name

  alias :categories :tags
  alias :categories= :tags=

  named_scope :tagged_by_id, lambda { |tag_id| { :include => :tags, :conditions => ["tags.id = ?", tag_id], :order => "taggings.highlighted DESC" } }
  named_scope :all_in_range, lambda { |range_id| { :conditions => ["product_range_id = ?", range_id], :order => "highlighted DESC, name ASC" } }
  named_scope :all_categories, :include => :tags, :order => "highlighted DESC, name ASC"
  named_scope :all_by_code, :include => :tags, :order => "code ASC"

  def range_and_name
    "Lloyd Loom of Spalding - #{self.range_name} - #{self.name}"
  end

  def range_name
    self.product_range.name if !product_range.blank?
  end

  def to_s
    "[#{self.id}] #{self.name}"
  end
end
