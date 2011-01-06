class ProductRange < ActiveRecord::Base         
  # translates :name, :description
  has_many :products, :dependent => :destroy
  named_scope :all_asc, :order => "name ASC"

  acts_as_friendly_param :name

  has_attached_file :image,
                    :styles => { :medium => "480x320>",
                                 :thumb => "144x96>" }  
                                 
  # validates_length_of :name,    :within => 3..4

end
