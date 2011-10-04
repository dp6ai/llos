class Stockist < ActiveRecord::Base

  validates_presence_of :name, :postcode

  geocoded_by :location

  def location
    [address_line_one, address_line_one, town, city, postcode].compact.join(', ')
  end

  after_validation :fetch_coordinates

end
