class AddPreviewImageToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :preview_image_file_name,    :string
    add_column :projects, :preview_image_content_type, :string
    add_column :projects, :preview_image_file_size,    :integer
    add_column :projects, :preview_image_updated_at,   :datetime
  end

  def self.down
    add_column :projects, :preview_image_file_name
    add_column :projects, :preview_image_content_type
    add_column :projects, :preview_image_file_size
    add_column :projects, :preview_image_updated_at
  end

end
