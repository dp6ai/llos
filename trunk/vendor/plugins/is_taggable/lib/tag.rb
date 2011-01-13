class Tag < ActiveRecord::Base

  translates :name
    
  class << self
    def find_or_initialize_with_name_like_and_kind(name, kind)
      with_name_like_and_kind(name, kind).first || new(:name => name, :kind => kind)
    end
  end

  has_many :taggings, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :kind
  validates_uniqueness_of :name, :scope => :kind

  named_scope :with_name_like_and_kind, lambda { |name, kind| { :conditions => ["name like ? AND kind = ?", name, kind] } }
  named_scope :of_kind,                 lambda { |kind| { :conditions => {:kind => kind} } } #MSP this breaks bad with i18n :(
  named_scope :all_asc, :order => "name ASC"
  named_scope :all_asc_by_kind, :order => "kind ASC, name ASC"
  named_scope :types_asc, :conditions => "kind = 'type'" ,:order => "name ASC"
  named_scope :rooms_asc, :conditions => "kind = 'room'" ,:order => "name ASC"
  named_scope :outdoors_asc, :conditions => "kind = 'outdoor'" ,:order => "name ASC"
end
