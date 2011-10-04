class Stockist < ActiveRecord::Base

  validates_presence_of :name, :postcode

end
