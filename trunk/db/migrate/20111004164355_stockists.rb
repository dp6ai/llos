class Stockists < ActiveRecord::Migration
  def self.up
    create_table :stockists do |t|
      t.string :name
      t.string :address_line_one
      t.string :address_line_two
      t.string :town
      t.string :city
      t.string :postcode
      t.timestamps
    end
  end

  def self.down
    drop_table :stockists
  end
end
