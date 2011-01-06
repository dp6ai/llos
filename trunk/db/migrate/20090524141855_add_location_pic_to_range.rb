class AddLocationPicToRange < ActiveRecord::Migration
  def self.up
    add_column :product_ranges, :image_file_name,    :string
    add_column :product_ranges, :image_content_type, :string
    add_column :product_ranges, :image_file_size,    :integer
    add_column :product_ranges, :image_updated_at,   :datetime

  end

  def self.down
    remove_column :product_ranges, :image_file_name
    remove_column :product_ranges, :image_content_type
    remove_column :product_ranges, :image_file_size
    remove_column :product_ranges, :image_updated_at
  end
end
