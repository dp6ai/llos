class NewsItem < ActiveRecord::Base

  acts_as_friendly_param :headline

  validates_presence_of :headline
  validates_presence_of :content

  has_attached_file :image,
                    :styles => { :medium => "480x320>",
                                 :thumb => "144x96>" }

  has_attached_file :doc
end
