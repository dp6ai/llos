class AddExtraFieldsToContactForm < ActiveRecord::Migration
  def self.up
    add_column :messages, :company_name, :string
    add_column :messages, :address, :string
    add_column :messages, :callmeback, :boolean
    add_column :messages, :member_of_public, :boolean
    add_column :messages, :shop_owner, :boolean
    add_column :messages, :architect, :boolean
    add_column :messages, :other, :boolean
    add_column :messages, :other_detail, :string

    add_column :messages, :indoor, :boolean
    add_column :messages, :outdoor, :boolean
    add_column :messages, :naturals, :boolean
  end

  def self.down
    remove_column :messages, :company_name
    remove_column :messages, :address
    remove_column :messages, :callback
    remove_column :messages, :member_of_public
    remove_column :messages, :shop_owner
    remove_column :messages, :architect
    remove_column :messages, :other
    remove_column :messages, :other_detail

    remove_column :messages, :indoor
    remove_column :messages, :outdoor
    remove_column :messages, :naturals
  end
end
