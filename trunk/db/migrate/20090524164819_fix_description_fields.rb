class FixDescriptionFields < ActiveRecord::Migration
  def self.up
    change_column(:products, :description, :text) 
  end

  def self.down
  end
end
