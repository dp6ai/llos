class AddWhereMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :where, :string
  end

  def self.down
    remove_column :messages, :where
  end
end

