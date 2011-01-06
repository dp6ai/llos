class AddFurtherInfoToContactForm < ActiveRecord::Migration
  def self.up
    add_column :messages, :further_info, :boolean
  end

  def self.down
    remove_column :messages, :further_info
  end
end
