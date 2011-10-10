class Asset < ActiveRecord::Base
  has_attached_file :asset,
                    :styles => { :medium => "480x320>",
                                 :thumb => "144x96>" }

  validates_presence_of :name

  is_taggable :tags
end
