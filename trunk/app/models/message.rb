class Message < ActiveRecord::Base
  validates_presence_of :name, :email, :phone, :subject, :address
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def validate 
    errors.add("Not choosing either member of public or trade") if member_of_public.blank? && shop_owner.blank? 
  end

end
