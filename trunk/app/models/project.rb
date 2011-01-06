class Project < ActiveRecord::Base
  acts_as_friendly_param :title

  validates_presence_of :title
  validates_presence_of :description

  has_attached_file :preview_image
  
  has_attached_file :image,
                    :styles => { :medium => "480x320>",
                                 :thumb => "144x96>" }

end
